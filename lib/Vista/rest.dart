import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class rest extends StatefulWidget {
  final String location;
  rest(this.location);
  @override
  restApp createState() => restApp();
}

class restApp extends State<rest> {
  TextEditingController id=TextEditingController();
  TextEditingController temperatura=TextEditingController();
  TextEditingController altitud=TextEditingController();
  TextEditingController humedad=TextEditingController();
  var dataHttp='';

  consumirGet(var id) async {
    print (widget.location);
    try {
      Response response =
      await get(Uri.parse('https://jsonplaceholder.typicode.com/users/' + id));
      http://api.weatherunlocked.com/api/current/4.917,%20-74.1?app_id=02546387&app_key=3ba0a43c2bc6266199961c600f7e5fa8
      await get(Uri.parse('http://api.weatherunlocked.com/api/current/'+widget.location+'?app_id=02546387&app_key=3ba0a43c2bc6266199961c600f7e5fa8'));
      Map data = jsonDecode(response.body);
      print('NAME: ${data['name']} /// username: ${data['username']}');
      print(data);
      print(response.statusCode.toString() + " Código de respuesta");
      if (response.statusCode.toString() == '200') {
        temperatura.text = '${data['temp_c']} C°';
        altitud.text='${data['alt_m']} mts';
        humedad.text='${data['humid_pct']} %';

        //correo.text='${data['email']}';
        //username.text='${data['username']}';
      }
    }catch(e){
      print(e);
    }
  }

  consumirPost()async{
    Response response = await post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {'title': 'Post Title', 'body': 'Lorem ipsum', 'userId': '1'}
    );
    Map data = jsonDecode(response.body);
    print(data);
    dataHttp= await response.body.toString();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Consumir servicio'),
        backgroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: id,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'ID',
                    hintText: 'Digite id de usuario',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(500, 50),
                    primary: Colors.black45,
                  ),
                  onPressed: () {
                    consumirGet(id.text);
                  },
                  child: Text('GET'),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(500, 50),
                    primary: Colors.black45,
                  ),
                  onPressed: () {
                    consumirPost();
                  },
                  child: Text('POST'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: temperatura,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Temperatura',
                    hintText: 'Temperatura',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: altitud,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Altitud',
                    hintText: 'Altitud',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  enabled: false,
                  controller: humedad,
                  decoration: InputDecoration(
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Humedad',
                    hintText: 'Humedad',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10),
                  child: Text("Data "+dataHttp))
            ],
          ),
        ),
      ),
    );
  }
}