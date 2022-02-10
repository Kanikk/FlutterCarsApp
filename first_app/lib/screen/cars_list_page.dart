import 'package:drift/drift.dart' as dr;
import 'package:first_app/screen/cars_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:first_app/database/car_database.dart';
import 'package:provider/provider.dart';
import 'package:first_app/theme/appThemes.dart';

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
        centerTitle: true,
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
                id: dr.Value(1),
                brand: dr.Value(''),
                color: dr.Value(1),
                mileage: dr.Value(1)),
          );
        }),
        shape: CircleBorder(
          side: BorderSide(color: contrast2, width: 3),
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
        return Card(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                // Expanded(),
                Expanded(
                  child: ListTile(
                    title: Text(carData.brand),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(carData.mileage.toString() + " km"),
                  ),
                ),
              ],
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
