import 'package:drift/drift.dart';
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
  var textInfoStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: contrast2);
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
                id: Value(1),
                brand: Value(''),
                color: Value('white'),
                mileage: Value(1)),
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
    return Container();
  }

  void _navigateToDetail(String title, CarCompanion carCompanion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailPage(
          carCompanion: carCompanion,
          title: title,
        ),
      ),
    );
  }
}
