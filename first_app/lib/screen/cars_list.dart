import 'package:flutter/material.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikacja samochodowa"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Hello world!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
