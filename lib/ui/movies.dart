import 'dart:ui';

import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'books_list.dart';
import 'movies_list.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key key}) : super(key: key);

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Color(0xff00008B),
        ),backgroundColor: Colors.grey,
        body: Center(

            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              CarouselSlider(

                items: [


                  SizedBox(


                      width: 300.0,
                      height: 800.0,
                      child: ListTile(



                          tileColor: Colors.lightBlue[600],



                          title: Center(




                            child: Text('Adventure Movies',


                                style: const TextStyle(


                                    color: Colors.white, fontSize: 35)),

                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MoviesList(types: 1)),
                            );
                          })),
                  SizedBox(
                      width: 300.0,
                      height: 800.0,
                      child: ListTile(
                          tileColor: Colors.lightBlue[700],
                          // title: Text(notes[index]['id']),
                          title: Center(
                            child: Text('Comedy Movies',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MoviesList(types: 2)),
                            );
                          })),
                  SizedBox(
                      width: 300.0,
                      height: 800.0,
                      child: ListTile(
                          tileColor: Colors.lightBlue[800],
                          // title: Text(notes[index]['id']),
                          title: Center(
                            child: Text('Horror Movies',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MoviesList(types: 3)),
                            );
                          })),

                ],
                //Slider Container properties
                options: CarouselOptions(
                  autoPlay: true,
                ),
              )
            ])));
  }

  getData() async {
    var notes = await DatabaseHelper.instance.getAllMovies();
    var dd = await DatabaseHelper.instance.getAllUsers();
    print(notes);
    print(dd);
  }
}
