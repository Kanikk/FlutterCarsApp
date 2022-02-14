import 'package:first_app/database/car_database.dart';
import 'package:first_app/widgets/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart' as dr;

class CarDetailPage extends StatefulWidget {
  final String title;
  final CarCompanion carCompanion;
  const CarDetailPage({
    Key? key,
    required this.carCompanion,
    required this.title,
  }) : super(key: key);
  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  late CarDatabase carDatabase;
  late TextEditingController mileageEditingcontroller;
  int color = 0;

  @override
  void initState() {
    super.initState();
    mileageEditingcontroller = TextEditingController();
    mileageEditingcontroller.text =
        widget.carCompanion.mileage.value.toString();
    color = widget.carCompanion.color.value!;
  }

  @override
  Widget build(BuildContext context) {
    carDatabase = Provider.of<CarDatabase>(context);
    return Scaffold(
      appBar: _getDetailAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          ColorPicker(
              index: color,
              onTap: (selectedColor) {
                color = selectedColor;
                setState(() {});
              }),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: mileageEditingcontroller,
            maxLength: 6,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                labelText: "Mileage",
                prefixIcon: const Icon(
                  Icons.call_made,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter mileage"),
          )
        ]),
      ),
    );
  }

//    Visual section

  _getDetailAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
          )),
      title: Text(
        widget.title,
      ),
      actions: [
        IconButton(
          onPressed: () {
            _saveToDb();
          },
          icon: const Icon(
            Icons.save,
          ),
        ),
        IconButton(
          onPressed: () {
            _deleteCar();
          },
          icon: const Icon(
            Icons.delete,
          ),
        ),
      ],
    );
  }

//    Database section

  void _saveToDb() {
    if (widget.carCompanion.id.present) {
      carDatabase
          .updateCar(
        CarData(
          id: widget.carCompanion.id.value,
          brand: "BMW",
          mileage: int.parse(mileageEditingcontroller.text),
          color: color,
        ),
      )
          .then(
        (value) {
          Navigator.pop(context, true);
        },
      );
    } else {
      carDatabase
          .insertCar(
        CarCompanion(
          mileage: dr.Value(
            int.parse(mileageEditingcontroller.text),
          ),
          color: dr.Value(color),
          brand: dr.Value("BMW"),
        ),
      )
          .then(
        (value) {
          Navigator.pop(context, true);
        },
      );
    }
  }

  void _deleteCar() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Car?'),
          content: const Text('Do you want to delete this car?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                carDatabase
                    .deleteCar(CarData(
                  id: widget.carCompanion.id.value,
                  brand: widget.carCompanion.brand.value,
                  mileage: widget.carCompanion.mileage.value,
                  color: widget.carCompanion.color.value,
                ))
                    .then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
