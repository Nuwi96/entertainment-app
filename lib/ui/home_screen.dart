import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CollectionReference _users =
  FirebaseFirestore.instance.collection('login_user');

  var userArray = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _users.get();

    setState(() {
      userArray = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xff00008B),
      ),
      body: Center(
        child: Text(!userArray[0]['logged_in'] ? 'Welcome To EDU APP' : 'Welcome ADMIN ', style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.6))),
      )
    );
  }
}
