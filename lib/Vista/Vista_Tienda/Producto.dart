import 'package:flutter/material.dart';
import 'package:proyectolineados/Vista/Vista_Tienda/ProductoDTO.dart';

class Producto extends StatefulWidget{
  final ProductoDTO objetoTienda;
  Producto(this.objetoTienda);
  @override
  ProductoApp createState() => ProductoApp();
}
class ProductoApp extends State<Producto>{
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child:  Text(
                    widget.objetoTienda.nombreProducto,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.objetoTienda.precioProducto,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget textSection =  Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        widget.objetoTienda.detalleProducto,
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Productos',
      home: Scaffold(
        appBar: AppBar(
          title:  Text(widget.objetoTienda.nombreProducto),
        ),
        body:

        ListView(
          children: [
            Image.asset(
              'Image/'+widget.objetoTienda.imagenProducto,
              width: 100,
              height: 300,
              fit: BoxFit.cover,
            ),
            titleSection,
            // buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

}