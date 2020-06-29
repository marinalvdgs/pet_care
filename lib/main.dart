import 'package:flutter/material.dart';
import 'package:pets_shelter/myScaffold.dart';
import 'package:pets_shelter/data/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      title: 'Pets shelter',
      home: MyScaffold(),
    );
  }
}
