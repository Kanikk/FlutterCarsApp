import 'package:first_app/widgets/change_theme_button_widget.dart';
import 'package:flutter/material.dart';
// import 'dart:math' as math;
import 'package:drift/drift.dart' as dr;
import 'package:provider/provider.dart';
import 'package:first_app/screen/cars_detail_page.dart';
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
        title: const Text(
          "Aplikacja samochodowa",
        ),
        actions: [
          ChangeThemeButtonWidget(),
          // Transform.rotate(
          //   angle: 35 * math.pi / 180,
          //   child: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.brightness_2_rounded,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: FutureBuilder<List<CarData>>(
        future: _getCarFromDatabase(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<CarData>? carList = snapshot.data;
            if (carList != null) {
              if (carList.isEmpty) {
                return const Center(
                    child: Text(
                  'No cars found',
                ));
              } else {
                return carListUI(carList);
              }
            }
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(
              child: Text(
            'Click on add button to add new car',
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
        shape: const CircleBorder(
          side: BorderSide(width: 1.2),
        ),
        child: const Icon(
          Icons.add,
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
}
