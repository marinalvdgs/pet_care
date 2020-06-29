import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc_provider.dart';
import 'package:pets_shelter/bloc/pets_bloc.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/widgets/pet_card.dart';

class AdoptPage extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  List<Pet> pets = [];

  PetsBloc _petsBloc;

  @override
  void initState() {
    _petsBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _petsBloc.allPets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            pets = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey.shade50,
                elevation: 0.5,
                title: Text(
                  'Pets',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Container(
                child: ListView.builder(
                    itemCount: pets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PetCard(pets[index],
                            _petsBloc.getFavIcon(pets[index].id.toString())),
                      );
                    }),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
