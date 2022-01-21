import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/tution.dart';
import 'package:flutter/material.dart';

import 'add_advertisement.dart';
import 'add_book.dart';
import 'home_screen.dart';
import 'lessons.dart';
import 'login_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.75), BlendMode.dstATop),
                    image: AssetImage('assets/images/note.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              )),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Books'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LessonsScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Tuition Advertisement'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TuitionScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: Text(userArray.isNotEmpty? (userArray[0]['logged_in']) ? 'LogOut' : 'Login':'Login'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SimpleLoginScreen()),
              )
            },
          ),
          userArray.isNotEmpty?userArray[0]['logged_in']
              ? ListTile(
                  leading: const Icon(Icons.house_sharp),
                  title: const Text('Add a book'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddBookScreen()),
                    )
                  },
                )
              : Text(''):Text(''),
          userArray.isNotEmpty?userArray[0]['logged_in']
              ? ListTile(
                  leading: const Icon(Icons.house_sharp),
                  title: const Text('Add Advertisement'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAdvertisement()),
                    )
                  },
                )
              : Text(''): Text(''),
        ],
      ),
    );
  }
}
