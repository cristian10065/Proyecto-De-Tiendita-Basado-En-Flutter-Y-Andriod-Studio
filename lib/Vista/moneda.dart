import 'dart:convert';
import 'package:flutter/material.dart' hide Key;
import 'package:http/http.dart';
class moneda extends StatefulWidget{

  @override
  MonedaApp createState() => MonedaApp();
}
class MonedaApp extends State<moneda>{
  TextEditingController peso = TextEditingController();
  TextEditingController dolar = TextEditingController();
  var dataHttp='';
  API(var moneda) async {
    try {
      Response response =
      await get(Uri.parse('https://api.apilayer.com/exchangerates_data/convert?to=USD&from=COP&amount='+moneda+'&apikey=2lARRK8oHfAGhQBWj1q8EM2powhIYsXh'));
      Map data = jsonDecode(response.body);
      //print('NAME: ${data['name']} /// username: ${data['username']}');
      // print(data);
      print(response.statusCode.toString() + " Código de respuesta");
      if (response.statusCode.toString() == '200') {
        dolar.text = '${data['result']}';
      }else{
        print("Error");
      }
    }catch(e){
      print(e);
    }

  }
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Service'),
        backgroundColor: Colors.blue,
      ),body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26, top: 10, right: 21),
              child: TextField(
                cursorColor: Colors.blue,
                controller: peso,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                    floatingLabelStyle:
                    const TextStyle(color: Colors.blue),
                    labelText: 'Peso colombiano',
                    hintText: 'Digíte la cantidad de pesos'),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 10, right: 21),
              child: TextField(
                cursorColor: Colors.blue,
                controller: dolar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                  floatingLabelStyle:
                  const TextStyle(color: Colors.blue),
                  labelText: 'Cantidad En Dolar',
                  hintText: '',),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, right: 10),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 26, top: 30, right: 10),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        print('boton presionado');
                        API(peso.text);
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                ),
              ),
            ),
          ],)
    ),
    );
  }
}