import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc.dart';
import 'package:pets_shelter/data/icons_assets.dart';
import 'package:pets_shelter/models/animals.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/repository/favorite_pets.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter/services.dart' show rootBundle;

class PetsBloc implements Bloc {
  final String _petsData = 'assets/data/pets.json';
  final FavoritePetsRepository _favoritePetsRepository;
  List<Pet> pets = [];
  animals _currentAnimal;

  PetsBloc(FavoritePetsRepository favoritePetsRepository): _favoritePetsRepository = favoritePetsRepository;
  final _petStateController = PublishSubject<List<Pet>>();

  StreamSink<List<Pet>> get _pets => _petStateController.sink;

  Stream<List<Pet>> get allPets => _petStateController.stream;

  final _favPetStateController = PublishSubject<List<Pet>>();

  StreamSink<List<Pet>> get _favPets => _favPetStateController.sink;

  Stream<List<Pet>> get favPets => _favPetStateController.stream;

  animals get currentAnimal => _currentAnimal;

  void changeCurrentAnimal(){
    if(_currentAnimal==animals.cat) _currentAnimal=animals.dog;
    else _currentAnimal = animals.cat;
  }

  @override
  void init() {
    _loadData();
    _loadFavPets();
    _currentAnimal=animals.dog;
  }

  _loadData() async {
    String data = await rootBundle.loadString(_petsData);
    var json = jsonDecode(data);
    json.forEach((item) {
      pets.add(Pet.fromMap(item));
    });
    _pets.add(pets);
  }

  Image getFavIcon(String id) {
    _favoritePetsRepository.loadFavs();
    return _favoritePetsRepository.isFavorite(id)
        ? Image.asset(fav)
        : Image.asset(favBorder);
  }

  _loadFavPets() async{
    Set<String> favsId = await _favoritePetsRepository.loadFavs();
    List<Pet> favpets= [];
    pets.forEach((pet){
      if(favsId.contains(pet.id.toString())){
        favpets.add(pet);
      }
    });
    _favPets.add(favpets);
  }

  @override
  void dispose() {
    _petStateController.close();
    _favPetStateController.close();
  }
}
