import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TuitionScreen extends StatefulWidget {
  const TuitionScreen({Key key}) : super(key: key);

  @override
  _TuitionScreenState createState() => _TuitionScreenState();
}

class _TuitionScreenState extends State<TuitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Color(0xff00008B),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'tution',
                  ),
                ])));
  }
}
