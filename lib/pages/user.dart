import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc_provider.dart';
import 'package:pets_shelter/bloc/pets_bloc.dart';
import 'package:pets_shelter/bloc/pets_info_bloc.dart';
import 'package:pets_shelter/models/pet.dart';
import 'package:pets_shelter/widgets/interaction_table.dart';
import 'package:pets_shelter/widgets/pet_card.dart';
import 'package:pets_shelter/widgets/pets_tile.dart';
import 'package:pets_shelter/widgets/small_pet_card.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  PetsBloc _petsBloc;
  List<Pet> _pets;

  @override
  void initState() {
    _petsBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _petsBloc.favPets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _pets = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey.shade50,
                elevation: 0.5,
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://media.istockphoto.com/photos/glasses-girl-in-white-picture-id1089633230?k=6&m=1089633230&s=612x612&w=0&h=FUHE3jCQMIrC72Ux8-rz_z3mHDi2UB61gceLSKAxEwg='))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Alice Smith',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              'alicesmith@example.com',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your pets',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'Pets you take care about',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: _pets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BlocProvider(
                              bloc: PetsInfoBloc(_pets[index].id),
                              child: PetsTile(_pets[index]),
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
