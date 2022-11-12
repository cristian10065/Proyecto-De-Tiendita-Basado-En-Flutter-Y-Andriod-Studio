
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectolineados/Vista/Vista_Tienda/ProductoDTO.dart';
import 'package:flutter/material.dart';

import 'Producto.dart';

class Tiendas extends StatefulWidget {
  TiendasApp createState() => TiendasApp();

}

class TiendasApp extends State<Tiendas> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController NombreT=TextEditingController();
  TextEditingController DescripT=TextEditingController();
  TextEditingController PrecioT=TextEditingController();
  TextEditingController rutaT=TextEditingController();

  registrarTienda() async {
    try {
      await firebase.collection("Productos").doc().set({
        'DescripProducto':DescripT.text,
        'NombreProducto':NombreT.text,
        'PrecioProdcuto':PrecioT.text,
        'ruta':rutaT.text
        /*
        'DescripProducto':item.detalleProducto,
        'NombreProducto':item.nombreProducto,
        'PrecioProdcuto':item.precioProducto,
        'ruta':item.imagenProducto*/
      });
    } catch (e) {
      print(e);
    }
  }
  ProductoDTO tiendaObjeto = ProductoDTO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Mi Tienda'),
        actions: [
          IconButton(
            onPressed: () {
              mensaje('Registro','Crear nueva tienda');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection("Productos").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data!.docs.length, // define las iteraciones
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                        const EdgeInsets.only(bottom: 10),
                                        child: Text(snapshot.data!.docs[index]
                                            .get("NombreProducto"))),
                                    Text(
                                      snapshot.data!.docs[index].get("DescripProducto"),
                                      style: TextStyle(color: Colors.green[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 30, top: 0, bottom: 0, left: 0),
                                width: 80,
                                height: 80,
                                child: Image.asset('Image/'+snapshot.data!.docs[index].get("ruta")),
                              ),
                              IconButton(
                                onPressed: () {
                                  tiendaObjeto.idProducto =snapshot.data!.docs[index].id;
                                  tiendaObjeto.nombreProducto = snapshot.data!.docs[index].get("NombreProducto");
                                  tiendaObjeto.detalleProducto = snapshot.data!.docs[index].get("DescripProducto");
                                  tiendaObjeto.imagenProducto =snapshot.data!.docs[index].get("ruta");
                                  tiendaObjeto.precioProducto = snapshot.data!.docs[index].get("PrecioProducto");
                                  Navigator.push( context,MaterialPageRoute(builder: (_) =>Producto(tiendaObjeto)));
                                },
                                //  child: Text('Entrar'))
                                icon: const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  //************** MENSAJE****************************************
  void mensaje(String titulo, String mess) {

    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[

              Padding(
                padding:
                EdgeInsets.only(left: 5, top:5, right: 5, bottom: 0),
                child: TextField(
                  controller: NombreT ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre Producto',
                    hintText: 'Digite el nombre del producto',
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                child: TextField(
                  controller: DescripT,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Detalle Producto',
                    hintText: 'Digite el Detalle del producto',
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                child: TextField(
                  controller: PrecioT,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Precio Producto',
                    hintText: 'Digite el precio del producto',
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                child: TextField(
                  controller: rutaT,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre imagen',
                    hintText: 'Digite el imagen del producto',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  registrarTienda();
                  print('Registrando...');
                  Navigator.of(context).pop();
                },
                child:
                Text("Aceptar", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child:
                Text("Cancelar", style: TextStyle(color: Colors.black)),
              )
            ],
          );
        });
  }
}
