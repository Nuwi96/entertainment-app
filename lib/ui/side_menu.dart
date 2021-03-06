import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/movies.dart';
import 'package:education_app/ui/tv_shows_popular.dart';
import 'package:flutter/material.dart';
import 'add_movie.dart';
import 'add_book.dart';
import 'add_music.dart';
import 'add_tv_show.dart';
import 'home_screen.dart';
import 'books.dart';
import 'login_screen.dart';
import 'musics.dart';
import 'movies.dart';

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
    return Drawer(backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.75), BlendMode.dstATop),
                    image: AssetImage('assets/images/en.jpg'),
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Books'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonsScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Movies'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoviesScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Music'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MusicsScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Tv Shows'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TvShows()),
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
                          builder: (context) => AddBookScreen()),
                    )
                  },
                )
              : Text(''):Text(''),
          userArray.isNotEmpty?userArray[0]['logged_in']
              ? ListTile(
                  leading: const Icon(Icons.house_sharp),
                  title: const Text('Add Movie'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMovieScreen()),
                    )
                  },
                )
              : Text(''): Text(''),

          userArray.isNotEmpty?userArray[0]['logged_in']
              ? ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add Music'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddMusicScreen()),
              )
            },
          )
              : Text(''): Text(''),
          userArray.isNotEmpty?userArray[0]['logged_in']
              ? ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add Tv Show'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTvShow()),
              )
            },
          )
              : Text(''): Text(''),
        ],
      ),
    );
  }
}
