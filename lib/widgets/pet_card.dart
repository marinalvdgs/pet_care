import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pets_shelter/data/icons_assets.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/repository/favorite_pets.dart';

class PetCard extends StatefulWidget {
  final Pet pet;
  final Image icon;

  PetCard(this.pet, this.icon);

  @override
  _PetCardState createState() => _PetCardState(pet, icon);
}

class _PetCardState extends State<PetCard> {
  Pet pet;
  FavoritePetsRepository _petsRepository;
  Image favIcon;

  _PetCardState(this.pet, this.favIcon);

  @override
  void initState() {
    _petsRepository = FavoritePetsRepository();
    super.initState();
  }

  _getIcon() {
    if (pet.sex == 'male')
      return new Image.asset(
        male,
        height: 30,
        width: 30,
      );
    else
      return new Image.asset(
        female,
        height: 30,
        width: 30,
      );
  }

  _getFavIcon() {
    return _petsRepository.isFavorite(pet.id.toString())
        ? Image.asset(fav)
        : Image.asset(favBorder);
  }

  _getToastMsg() =>
    _petsRepository.isFavorite(pet.id.toString())?'You will take care of ${pet.name} :)' : 'Someone else will take care of ${pet.name} :(';

  _onFavIconTap(){
    setState(() {
      _petsRepository.switchFavoriteStatus(pet.id.toString());
      favIcon = _getFavIcon();
    });
    Fluttertoast.showToast(msg: _getToastMsg());
  }

  @override
  Widget build(BuildContext context) {
    _petsRepository.loadFavs();
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: Image.network(
                    pet.photo,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${pet.name}, ${pet.age} years',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  'Breed: ${pet.breed}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    pet.description,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 16, top: 8),
                          child: Tab(
                            icon: _getIcon(),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: _onFavIconTap,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tab(
                      icon: favIcon,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
