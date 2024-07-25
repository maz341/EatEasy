import 'dart:convert';

import 'package:eat_easy/models/models.dart';
import 'package:eat_easy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return ourDb;
  }

  void _onCreate(Database database, int version) async {
    debugPrint("Table is created");
    await database.execute('''CREATE TABLE $cartTableName( 
            $cartItemName TEXT NOT NULL,
             $cartProduct TEXT NOT NULL, 
             $cartId TEXT NOT NULL, 
             $cartQuantity INTEGER NOT NULL)''');
    debugPrint(' $cartTableName table created.......');

    await database.execute('''CREATE TABLE $userTable( 
            $userName TEXT NOT NULL,
             $userId TEXT NOT NULL, 
             $userPassword TEXT NOT NULL,
             $userEmail TEXT NOT NULL)''');
    debugPrint(' $userTable table created.......');

    await database.execute('''CREATE TABLE $orderTable( 
            $orderId TEXT NOT NULL,
             $orderAmount INTEGER NOT NULL,
             $orderQuantity INTEGER NOT NULL,
             $orderStatus TEXT NOT NULL,
             $orderAddress TEXT NOT NULL,
             $orderDate TEXT NOT NULL,
             $orderImage TEXT NOT NULL,
             $orderProducts TEXT NOT NULL)''');
    debugPrint(' $orderTable table created.......');

    await database.execute('''CREATE TABLE $addressTable( 
            $addressId TEXT NOT NULL,
             $addressType TEXT NOT NULL, 
             $addressAddress TEXT NOT NULL,
             $addressPostalCode TEXT NOT NULL)''');
    debugPrint(' $addressTable table created.......');
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {}
  }

  ////////
  //  Auth Start
  ///////
  Future<int> saveUser(User user) async {
    int res = 0;

    // Getting all users
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(userTable);

    List<User> modelDatabase =
        result.map((value) => User.fromJson(value)).toList();

    for (var element in modelDatabase) {
      debugPrint(jsonEncode(element));
    }

    var queryResult = await dbClient
        .rawQuery("SELECT * FROM $userTable WHERE $userId='${user.id}'");

    queryResult.isEmpty
        ? res = await dbClient.insert(userTable, user.toJson())
        : debugPrint("Data already exist in DB");

    return res;
  }

  Future<bool> validateUser(String email, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(userTable);
    List<User> users = result.map((value) => User.fromJson(value)).toList();
    debugPrint("users Length ${users.length}");
    for (var user in users) {
      if (user.email == email && user.password == password) {
        debugPrint("Kamal ${jsonEncode(user)}");
        return true;
      }
    }
    return false;
  }

  Future<List<User>> getAllUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(
      userTable,
    );

    List<User> modelDatabase =
        result.map((value) => User.fromJson(value)).toList();

    debugPrint("\n\nfrom DB $modelDatabase");
    debugPrint("My select * from database $result");

    return modelDatabase.isEmpty ? [] : modelDatabase;
  }
  ////////
  //  Auth Ends
  ///////
  ///

  ////////
  //  Orders Start
  ///////

  Future<List<Order>> getAllOrders() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(orderTable);

    List<Order> modelDatabase =
        result.map((value) => Order.fromJson(value)).toList();

    debugPrint("\n\nfrom DB $modelDatabase");
    debugPrint("My select * from database $result");

    return modelDatabase.isEmpty ? [] : modelDatabase;
  }

  Future<int> saveOrder(Order order) async {
    int res = 0;

    // Getting all orders
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(orderTable);

    List<Order> modelDatabase =
        result.map((value) => Order.fromJson(value)).toList();

    for (var element in modelDatabase) {
      debugPrint(jsonEncode(element));
    }

    var queryResult = await dbClient.rawQuery(
        "SELECT * FROM $orderTable WHERE $orderId='${order.orderId}'");

    queryResult.isEmpty
        ? res = await dbClient.insert(orderTable, order.toJson())
        : debugPrint("Data already exist in DB");

    return res;
  }

  ////////
  //  Address Start
  ///////
  Future<int> saveAddress(Address address) async {
    int res = 0;

    // Getting all users
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(addressTable);

    List<Address> modelDatabase =
        result.map((value) => Address.fromJson(value)).toList();

    for (var element in modelDatabase) {
      debugPrint(jsonEncode(element));
    }

    var queryResult = await dbClient.rawQuery(
        "SELECT * FROM $addressTable WHERE $addressId='${address.addressId}'");

    queryResult.isEmpty
        ? res = await dbClient.insert(addressTable, address.toJson())
        : debugPrint("Data already exist in DB");

    return res;
  }

  Future<List<Address>> getAllAddress() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(addressTable);

    List<Address> modelDatabase =
        result.map((value) => Address.fromJson(value)).toList();

    debugPrint("\n\nfrom DB $modelDatabase");
    debugPrint("My select * from database $result");

    return modelDatabase.isEmpty ? [] : modelDatabase;
  }
}
