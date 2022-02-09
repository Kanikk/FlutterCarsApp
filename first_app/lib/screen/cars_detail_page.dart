import 'package:first_app/database/car_database.dart';
import 'package:first_app/theme/appThemes.dart';
import 'package:flutter/material.dart';

class CarDetailPage extends StatefulWidget {
  const CarDetailPage({
    Key? key,
    required this.carCompanion,
    required this.title,
  }) : super(key: key);
  final String title;
  final CarCompanion carCompanion;
  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getDetailAppBar(),
    );
  }

  _getDetailAppBar() {
    return AppBar(
      backgroundColor: contrast1,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: contrast2,
          )),
      title: Text(
        widget.title,
        style: TextStyle(color: contrast2),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.save,
            color: contrast2,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: contrast2,
          ),
        ),
      ],
    );
  }
}
