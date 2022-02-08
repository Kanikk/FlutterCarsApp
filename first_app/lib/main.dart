import 'package:first_app/screen/cars_list.dart';
import 'package:flutter/material.dart';
// import 'package:first_app/screen/cars_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cars in stock',
      home: CarListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
