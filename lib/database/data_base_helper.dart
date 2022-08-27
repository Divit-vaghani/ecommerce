import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/model/shopping_mall.dart';
import 'package:ecommerce/model/sum_total.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static const String _dataBaseName = 'shopping_bloc.db';
  static const int _dataBaseVersion = 1;

  static String table = 'Items';

  static String columnId = 'id';
  static String columnSlug = 'slug';
  static String columnTitle = 'title';
  static String columnDescription = 'description';
  static String columnPrice = 'price';
  static String columnFeaturedImage = 'featured_image';
  static String columnStatus = 'status';
  static String columnCreatedAt = 'created_at';
  static String columnCart = 'cart';

  static Database? _database;

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database?> get dataBase async {
    if (_database != null) return _database;
    return _database = await _initDataBase();
  }

  Future<bool> isDataBaseExist() async {
    Directory? documentDirectory = await getTemporaryDirectory();
    String path = join(documentDirectory.path, _dataBaseName);
    return databaseExists(path);
  }

  Future<Database?> _initDataBase() async {
    Directory? documentDirectory = await getTemporaryDirectory();
    String path = join(documentDirectory.path, _dataBaseName);
    return openDatabase(
      path,
      version: _dataBaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
         CREATE TABLE $table (
         $columnId INTEGER NOT NULL,
	       $columnSlug	TEXT NOT NULL,
	       $columnTitle	TEXT NOT NULL,
	       $columnDescription	TEXT NOT NULL,
	       $columnPrice	INTEGER,
	       $columnFeaturedImage	TEXT,
	       $columnStatus	TEXT,
	       $columnCreatedAt	TEXT,
	       $columnCart INTEGER
         )
      ''');
  }

  Future<List<Datum>> getCartItems() async {
    Database? db = await instance.dataBase;
    return List<Datum>.from(
      jsonDecode(
        jsonEncode(
          await db!.rawQuery("Select * from Items where cart=1"),
        ),
      ).map(
        (x) => Datum.fromJson(x),
      ),
    );
  }

  Future<List<SumPrice>> getTotalRate() async {
    Database? db = await instance.dataBase;
    return sumPriceFromJson(
      jsonEncode(
        await db!.rawQuery("SELECT SUM(price*status)FROM Items where cart=1"),
      ),
    );
  }

  Future<int> addToCart(Datum data) async {
    Database? db = await instance.dataBase;
    return db!.update(
      table,
      data.toJsonAddCart(),
      where: '$columnId = ?',
      whereArgs: [data.id],
    );
  }

  Future<int> addRemoveItem(Datum data) async {
    Database? db = await instance.dataBase;
    return db!.update(
      table,
      data.toJsonAddRemoveItem(),
      where: '$columnId = ?',
      whereArgs: [data.id],
    );
  }

  Future<int> insert(Datum data) async {
    Database? db = await instance.dataBase;
    return db!.insert(table, data.toJson());
  }

  Future<List<Datum>> queryAll() async {
    Database? db = await instance.dataBase;

    return List<Datum>.from(jsonDecode(jsonEncode(await db!.query(table)))
        .map((x) => Datum.fromJson(x)));
  }

  Future<int> update(ShoppingMall data, int? id) async {
    Database? db = await instance.dataBase;
    return db!.update(
      table,
      data.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    Database? db = await instance.dataBase;
    await db!.close();
  }
}
