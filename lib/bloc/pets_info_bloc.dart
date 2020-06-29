import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc.dart';
import 'package:pets_shelter/data/colors.dart';
import 'package:pets_shelter/repository/pets_db.dart';
import 'package:pets_shelter/models/pet_info.dart';
import 'package:rxdart/rxdart.dart';

class PetsInfoBloc implements Bloc{
  final int petId;
  List<PetInfo> info = [];
  dbPets pets = dbPets();

  PetsInfoBloc(this.petId);

  final _petStateController = PublishSubject<List<PetInfo>>();

  StreamSink<List<PetInfo>> get _petInfo => _petStateController.sink;

  Stream<List<PetInfo>> get allInfo => _petStateController.stream;

  @override
  void init() {
    _getData();
  }

  _getData() async {
    await pets.initalizeDb();
    List<Map> jsons = await pets.getPetInfo(petId);
    info = jsons.map((json) => PetInfo.fromJson(json)).toList();
    _petInfo.add(info);
  }

  save(PetInfo pet) async{
    await pets.insertPetInfo(pet);
    _getData();
  }

  getBoxShadowColor(){
    DateTime lastDay = _getLastDay();
    if(lastDay==null) return cardColors[0];
    DateTime today = DateTime.now();
    var difference = today.difference(lastDay);
    if(difference.inDays<7) return cardColors[2];
    if(difference.inDays>=7 && difference.inDays<14) return cardColors[1];
    if(difference.inDays>=14) return cardColors[0];
  }

  DateTime _getLastDay(){
    if(info.length==0) return null;
    else return info[0].date;
  }

  @override
  void dispose() {
    _petStateController.close();
  }
}