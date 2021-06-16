import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:flutter_challenge/table/Contractor.dart';

final String tableContractor = 'Contractor';
final String id = 'id';
final String civility = 'civility';
final String lastName = 'lastname';
final String firstName = 'firstname';
final String address_1 = 'address_1';
final String address_2 = 'address_2';
final String postalCode = 'postal_code';
final String city = 'city';
final String cellPhone = 'cell_phone';
final String email = 'email';

class ContractorDB {
  static final ContractorDB instance = ContractorDB._init();
  static Database _database;

  ContractorDB._init();

  var db;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB('Contractor.db');
    return _database;
  }

  Future<Database> initDB(String filePath) async {
    final dir = await getDatabasesPath();
    final path = join(dir, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $Contractor (
                   $id integer PRIMARY KEY,
                  $civility text NOT NULL,
                  $lastName text NOT NULL,
                  $firstName text NOT NULL,
                  $address_1 text NOT NULL,
                  $address_2 text NOT NULL,
                  $postalCode text NOT NULL,
                  $city text NOT NULL,
                  $email text NOT NULL UNIQUE,
                  $cellPhone text NOT NULL UNIQUE
    )
    ''');
    print("DataBase Ready to work");
  }

  Future<Contractor> insertContractor(Contractor contractors) async {
    final db = await database;
    final id = await db.insert("Contractor", contractors.toJson());
    print("new contractor created");
    return contractors.copy(id: id);
  }

  Future<List<Contractor>> getContractor() async {
    final db = await database;
    final result = await db.query(tableContractor);

    List<Contractor> list = result.isNotEmpty
        ? result.map((element) => Contractor.fromJson(element)).toList()
        : [];
    return list;
  }

  updateContractor(Contractor contractor) async {
    final db = await database;
    var res = await db.update("contractor", contractor.toJson(),
        where: "$id = ?", whereArgs: [contractor.id]);
    return res;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableContractor, where: '$id = ?', whereArgs: [id]);
  }
}
