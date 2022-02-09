import 'package:first_app/database/car_database.dart';
import 'package:first_app/screen/cars_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => CarDatabase(),
      child: const MaterialApp(
        title: 'Cars in stock',
        home: CarListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
