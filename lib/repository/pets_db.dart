import 'package:pets_shelter/models/pet_info.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class dbPets {
  static final dbPets _dbPets = dbPets._internal();
  String tblPet = "pet";
  String colId = "id";
  String colPetInfo = "petInfo";
  String colDescription = "description";
  String colDate = "date";

  dbPets._internal();

  factory dbPets() {
    return _dbPets;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initalizeDb();
    }
    return _db;
  }

  Future<Database> initalizeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "/pets.db";
    var dbHelper = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblPet($colId INTEGER PRIMARY KEY, $colPetInfo INTEGER, $colDescription TEXT, $colDate INTEGER)");
  }

  Future<int> insertPetInfo(PetInfo pet) async {
    Database db = await this.db;
    var result = await db.insert(tblPet, pet.toJson());
    return result;
  }

  Future<List> getPetInfo(int petId) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $tblPet WHERE $colPetInfo = $petId ORDER BY $colDate DESC");
    return result;
  }
}
