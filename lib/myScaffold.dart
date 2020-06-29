import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc_provider.dart';
import 'package:pets_shelter/bloc/pets_bloc.dart';
import 'package:pets_shelter/pages/adopt.dart';
import 'package:pets_shelter/pages/shelter.dart';
import 'package:pets_shelter/pages/user.dart';
import 'package:pets_shelter/repository/favorite_pets.dart';

class MyScaffold extends StatefulWidget {
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  int _currentItem = 0;

  void _onSelectedItem(int selected) {
    setState(() {
      _currentItem = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        currentItem: _currentItem,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentItem,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.pets), title: Text('Pets')),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Shelter')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text('User'))
        ],
        onTap: _onSelectedItem,
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  final int currentItem;

  AppBody({Key key, this.currentItem}) : super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    switch (widget.currentItem) {
      case 0:
        return BlocProvider(
          bloc: PetsBloc(FavoritePetsRepository()),
          child: AdoptPage(),
        );
      case 1:
        return ShelterPage();
      case 2:
        return BlocProvider(
            bloc: PetsBloc(FavoritePetsRepository()),
            child: UserPage()
        );
    }
    throw Exception('Invalid page');
  }
}
