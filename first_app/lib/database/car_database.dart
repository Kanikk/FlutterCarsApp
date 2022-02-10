import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'car_database.g.dart';

class Car extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get brand => text()();
  IntColumn get color => integer().nullable()();
  IntColumn get mileage => integer()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Car])
class CarDatabase extends _$CarDatabase {
  CarDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<CarData>> getCarList() async {
    return await select(car).get();
  }

  Future<int> insertCar(CarCompanion carCompanion) async {
    return await into(car).insert(carCompanion);
  }
}
