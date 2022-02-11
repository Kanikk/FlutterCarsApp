import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:drift/drift.dart' as dr;
import 'package:provider/provider.dart';
import 'package:first_app/screen/cars_detail_page.dart';
import 'package:first_app/theme/appThemes.dart';
import 'package:first_app/database/car_database.dart';
import 'package:first_app/widgets/color_picker.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);

  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  late CarDatabase database;

  @override
  Widget build(BuildContext context) {
    database = Provider.of<CarDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: contrast1,
        title: Text(
          "Aplikacja samochodowa",
          style: TextStyle(color: contrast2),
        ),
        actions: [
          Transform.rotate(
            angle: 35 * math.pi / 180,
            child: IconButton(
              onPressed: () {
                // _changeColor();
              },
              icon: Icon(
                Icons.brightness_2_rounded,
                color: contrast2,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<CarData>>(
        future: _getCarFromDatabase(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<CarData>? carList = snapshot.data;
            if (carList != null) {
              if (carList.isEmpty) {
                return Center(
                    child: Text(
                  'No cars found',
                  style: textInfoStyle,
                ));
              } else {
                return carListUI(carList);
              }
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(
              child: Text(
            'Click on add button to add new car',
            style: textInfoStyle,
          ));
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _navigateToDetail(
            "Add car",
            const CarCompanion(
                brand: dr.Value(''), color: dr.Value(0), mileage: dr.Value(0)),
          );
        }),
        shape: CircleBorder(
          side: BorderSide(color: contrast2, width: 1.2),
        ),
        backgroundColor: contrast1,
        child: Icon(
          Icons.add,
          color: contrast2,
        ),
      ),
    );
  }

  Future<List<CarData>> _getCarFromDatabase() async {
    return await database.getCarList();
  }

  Widget carListUI(List<CarData> carList) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: carList.length,
      itemBuilder: (context, index) {
        CarData carData = carList[index];
        return InkWell(
          onTap: () {
            _navigateToDetail(
              "Edit Car",
              CarCompanion(
                id: dr.Value(carData.id),
                brand: dr.Value(carData.brand),
                mileage: dr.Value(carData.mileage),
                color: dr.Value(carData.color),
              ),
            );
          },
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      trailing: Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Color"),
                            Container(
                              color: colors[carData.color!],
                              width: 15,
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text("Brand: " + carData.brand),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(carData.mileage.toString() + " km"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _navigateToDetail(String title, CarCompanion carCompanion) async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailPage(
          carCompanion: carCompanion,
          title: title,
        ),
      ),
    );
    if (res != null && res == true) {
      setState(() {});
    }
  }

  _getColor(int parameter) {
    switch (parameter) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.black;
      default:
        return Colors.green;
    }
  }
}
