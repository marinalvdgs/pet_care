import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/pets_info_bloc.dart';
import 'package:pets_shelter/models/pet_info.dart';

class InteractionTable extends StatefulWidget {
  final PetsInfoBloc petsInfoBloc;
  InteractionTable(this.petsInfoBloc);
  @override
  _InteractionTableState createState() => _InteractionTableState(petsInfoBloc);
}

class _InteractionTableState extends State<InteractionTable> {
  List<PetInfo> _infoList;
  PetsInfoBloc _petsInfoBloc;

  _InteractionTableState(this._petsInfoBloc);

  _onTapAddButton() {
    showDialog(
        context: context,
        builder: (BuildContext context) => _addInteractionUI(PetInfo(_petsInfoBloc.petId, '', DateTime.now())));
  }

  Widget content() {
    if (_infoList.length == 0) {
      return Container(
          height: 100,
          child: Center(
            child: Text('Here will be a interaction history'),
          ));
    } else
      return Container(
        height: 100,
        child: ListView.builder(
            itemCount: _infoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _infoList[index].date.year.toString() +
                                  '-' +
                                  _infoList[index].date.month.toString() +
                                  '-' +
                                  _infoList[index].date.day.toString(),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _infoList[index].description,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              );
            }),
      );
  }
  
  save(PetInfo pet){
    _petsInfoBloc.save(pet);
    Navigator.pop(context);
  }

  _addInteractionUI(PetInfo pet){
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      blurRadius: 8.0),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Give a short description',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            pet.description = value;
                          });
                        },
                        maxLength: 70,
                        decoration: InputDecoration(labelText: 'Type here'),
                      ),
                    ),
                    Text(
                      'Mark the day of visit',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DateField(
                            onDateSelected: (value) {
                              setState(() {
                                pet.date = value;
                              });
                            },
                            selectedDate: pet.date),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 8,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(24.0)),
                              highlightColor: Colors.transparent,
                              onTap: () {
                                save(pet);
                              },
                              child: Center(
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    //color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _petsInfoBloc.allInfo,
        builder: (context, snapshot) {
          _infoList = _petsInfoBloc.info;
          return Container(
            height: 150,
            child: Column(
              children: <Widget>[
                content(),
                RaisedButton.icon(
                  onPressed: _onTapAddButton,
                  icon: Icon(Icons.add),
                  label: Text('Add new interaction'),
                )
              ],
            ),
          );
        });
  }
}
