import 'package:flutter/material.dart';
import 'package:task_week_1/ListOfProducts.dart';
//import 'home_screen.dart';
//has all the essential components and widgets

void main() {
  runApp(const MyApp());
  //call the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  //method called build of type widget
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProdList(),
    );
  }
}



