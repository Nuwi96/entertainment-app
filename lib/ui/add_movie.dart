import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAdvertisement extends StatefulWidget {
  const AddAdvertisement({Key key}) : super(key: key);

  @override
  _AddAdvertisementState createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
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
                    'Add Add',
                  ),
                ])));
  }
}
