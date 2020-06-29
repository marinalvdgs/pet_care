import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc_provider.dart';
import 'package:pets_shelter/bloc/pets_info_bloc.dart';
import 'package:pets_shelter/data/colors.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/models/pet_info.dart';
import 'package:pets_shelter/repository/pets_db.dart';

dbPets pets = dbPets();

class SmallPetCard extends StatefulWidget {
  final Pet pet;
  final PetsInfoBloc petsInfoBloc;
  SmallPetCard(this.pet, this.petsInfoBloc);
  @override
  _SmallPetCardState createState() => _SmallPetCardState(pet, petsInfoBloc);
}

class _SmallPetCardState extends State<SmallPetCard> {
  Pet pet;
  DateTime lastDay;
  PetsInfoBloc _petsInfoBloc;
  _SmallPetCardState(this.pet, this._petsInfoBloc);

  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _petsInfoBloc.allInfo,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _petsInfoBloc.getBoxShadowColor().withOpacity(0.8),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      pet.photo)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        pet.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
