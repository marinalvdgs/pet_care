import 'package:flutter/material.dart';

class AnimalButton extends StatelessWidget {
  final String icon;
  final Function func;

  AnimalButton(this.icon, this.func);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 100,
      child: RaisedButton(
        child: Tab(
          icon: Image.asset(
            icon,
            height: 40.0,
          ),
        ),
        onPressed: func,
      ),
    );
  }
}