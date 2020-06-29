import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritePets {
  Stream<Set<String>> get favPets;

  bool isFavorite(String id);

  void switchFavoriteStatus(String id);

  Future<Set<String>> loadFavs();
}

class FavoritePetsRepository implements FavoritePets {
  static const _kFavoritePetsPreferenceKey = 'FAVORITE_PET';
  List<String> fPets = [];

  var _favPetsController = PublishSubject<Set<String>>();

  Stream<Set<String>> get favPets {
    loadFavs();
    return _favPetsController.stream;
  }

  Future<Set<String>> loadFavs() async {
    final _pref = SharedPreferences.getInstance();
    final pref = await _pref;
    fPets = pref.getStringList(_kFavoritePetsPreferenceKey) ?? [];
    _favPetsController.add(fPets.toSet());
    return fPets.toSet();
  }

  bool isFavorite(String id) {
    return fPets?.contains(id) ?? false;
  }

  void switchFavoriteStatus(String id) {
    final _pref = SharedPreferences.getInstance();
    if (isFavorite(id)) {
      fPets.remove(id);
    } else {
      fPets.add(id);
    }
    final favDots = fPets;
    _pref.then((value) {
      value.setStringList(_kFavoritePetsPreferenceKey, favDots);
    });
    _favPetsController.add(fPets.toSet());
  }
}
