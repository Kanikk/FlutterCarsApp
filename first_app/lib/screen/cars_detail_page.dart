import 'package:first_app/database/car_database.dart';
import 'package:first_app/theme/appThemes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart' as dr;

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
  late CarDatabase carDatabase;
  late TextEditingController mileageEditingcontroller;

  @override
  void initState() {
    super.initState();
    mileageEditingcontroller = TextEditingController();
    mileageEditingcontroller.text =
        widget.carCompanion.mileage.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    carDatabase = Provider.of<CarDatabase>(context);
    return Scaffold(
      appBar: _getDetailAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          TextFormField(
            controller: mileageEditingcontroller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter mileage"),
          )
        ]),
      ),
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
          onPressed: () {
            _saveToDb();
          },
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

  void _saveToDb() {
    carDatabase
        .insertCar(CarCompanion(
      mileage: dr.Value(
        int.parse(mileageEditingcontroller.text),
      ),
      color: dr.Value(1),
      brand: dr.Value("BMW"),
    ))
        .then((value) {
      Navigator.pop(context, true);
    });
  }
}
