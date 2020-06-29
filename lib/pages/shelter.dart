import 'package:flutter/material.dart';
import 'package:pets_shelter/widgets/map.dart';
import 'package:url_launcher/url_launcher.dart';

class ShelterPage extends StatefulWidget {
  @override
  _ShelterPageState createState() => _ShelterPageState();
}

class _ShelterPageState extends State<ShelterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0.5,
        title: Text(
          'Drug',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'About us',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'We help animals to find a new home and loving owners, and people faithful pets.\n'
              'Our organization is legally registered in the city of Omsk. For each animal gaining a new home, we fill out a contract - this allows you to keep records, track the fate of the animal and prevent arbitrariness in relation to it by new owners.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'How to help us',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'In the app, you can choose the pets that you will care for.\n'
                    'Find a friend (drug) here :)',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'To get more information go to ',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  child: Text(
                    'website',
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                  onTap: () => launch('https://dog-omsk.ru/'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Our location',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / 3,
              child: MapWidget())
        ],
      ),
    );
  }
}
