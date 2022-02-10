// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CarData extends DataClass implements Insertable<CarData> {
  final int id;
  final String brand;
  final int? color;
  final int mileage;
  CarData(
      {required this.id,
      required this.brand,
      this.color,
      required this.mileage});
  factory CarData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CarData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      brand: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}brand'])!,
      color: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}color']),
      mileage: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mileage'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['brand'] = Variable<String>(brand);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<int?>(color);
    }
    map['mileage'] = Variable<int>(mileage);
    return map;
  }

  CarCompanion toCompanion(bool nullToAbsent) {
    return CarCompanion(
      id: Value(id),
      brand: Value(brand),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      mileage: Value(mileage),
    );
  }

  factory CarData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CarData(
      id: serializer.fromJson<int>(json['id']),
      brand: serializer.fromJson<String>(json['brand']),
      color: serializer.fromJson<int?>(json['color']),
      mileage: serializer.fromJson<int>(json['mileage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'brand': serializer.toJson<String>(brand),
      'color': serializer.toJson<int?>(color),
      'mileage': serializer.toJson<int>(mileage),
    };
  }

  CarData copyWith({int? id, String? brand, int? color, int? mileage}) =>
      CarData(
        id: id ?? this.id,
        brand: brand ?? this.brand,
        color: color ?? this.color,
        mileage: mileage ?? this.mileage,
      );
  @override
  String toString() {
    return (StringBuffer('CarData(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('color: $color, ')
          ..write('mileage: $mileage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, brand, color, mileage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarData &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.color == this.color &&
          other.mileage == this.mileage);
}

class CarCompanion extends UpdateCompanion<CarData> {
  final Value<int> id;
  final Value<String> brand;
  final Value<int?> color;
  final Value<int> mileage;
  const CarCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.color = const Value.absent(),
    this.mileage = const Value.absent(),
  });
  CarCompanion.insert({
    this.id = const Value.absent(),
    required String brand,
    this.color = const Value.absent(),
    required int mileage,
  })  : brand = Value(brand),
        mileage = Value(mileage);
  static Insertable<CarData> custom({
    Expression<int>? id,
    Expression<String>? brand,
    Expression<int?>? color,
    Expression<int>? mileage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (color != null) 'color': color,
      if (mileage != null) 'mileage': mileage,
    });
  }

  CarCompanion copyWith(
      {Value<int>? id,
      Value<String>? brand,
      Value<int?>? color,
      Value<int>? mileage}) {
    return CarCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      mileage: mileage ?? this.mileage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (color.present) {
      map['color'] = Variable<int?>(color.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('color: $color, ')
          ..write('mileage: $mileage')
          ..write(')'))
        .toString();
  }
}

class $CarTable extends Car with TableInfo<$CarTable, CarData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CarTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String?> brand = GeneratedColumn<String?>(
      'brand', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int?> color = GeneratedColumn<int?>(
      'color', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _mileageMeta = const VerificationMeta('mileage');
  @override
  late final GeneratedColumn<int?> mileage = GeneratedColumn<int?>(
      'mileage', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, brand, color, mileage];
  @override
  String get aliasedName => _alias ?? 'car';
  @override
  String get actualTableName => 'car';
  @override
  VerificationContext validateIntegrity(Insertable<CarData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('mileage')) {
      context.handle(_mileageMeta,
          mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta));
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CarData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CarData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CarTable createAlias(String alias) {
    return $CarTable(_db, alias);
  }
}

abstract class _$CarDatabase extends GeneratedDatabase {
  _$CarDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CarTable car = $CarTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [car];
}
