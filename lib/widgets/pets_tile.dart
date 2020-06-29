import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc_provider.dart';
import 'package:pets_shelter/bloc/pets_info_bloc.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/widgets/interaction_table.dart';
import 'package:pets_shelter/widgets/small_pet_card.dart';

class PetsTile extends StatefulWidget {
  final Pet pet;

  PetsTile(this.pet);

  @override
  _PetsTileState createState() => _PetsTileState(pet);
}

class _PetsTileState extends State<PetsTile> {
  Pet _pet;
  PetsInfoBloc _petsInfoBloc;

  _PetsTileState(this._pet);

  @override
  void initState() {
    _petsInfoBloc = BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _petsInfoBloc.allInfo,
      builder: (context, snapshot) {
        return InkWell(
          child: SmallPetCard(_pet, _petsInfoBloc),
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (context) => InteractionTable(_petsInfoBloc));
          },
        );;
      }
    );
  }
}
