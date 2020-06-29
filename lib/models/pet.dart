import 'package:flutter/cupertino.dart';

class Pet{
  int _id;
  String _animal;
  String _sex;
  String _name;
  int _age;
  String _breed;
  String _description;
  String _photo;

  int get id => _id;
  String get animal => _animal;
  String get sex => _sex;
  String get name => _name;
  int get age => _age;
  String get breed => _breed;
  String get description => _description;
  String get photo => _photo;

  Pet.fromMap(Map<String, dynamic> map){
    _id = map['id'];
    _animal = map['animal'];
    _sex = map['sex'];
    _name = map['name'];
    _age = map['age'];
    _breed = map['breed'];
    _description = map['description'];
    _photo = map['photo'];
  }
}