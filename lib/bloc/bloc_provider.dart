import 'package:flutter/material.dart';
import 'package:pets_shelter/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  @override
  State<StatefulWidget> createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider<Bloc>> {
  @override
  Widget build(BuildContext context) {
    widget.bloc.init();
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
