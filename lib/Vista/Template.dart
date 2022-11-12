import 'package:flutter/material.dart';

class Plantilla extends StatefulWidget{
  PlantillaApp createState() => PlantillaApp();
}
class PlantillaApp extends State<Plantilla>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocalización'),

      ),
      body: SingleChildScrollView(),
    );
  }
}
