import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'books_list.dart';
import 'musics_list.dart';

class MusicsScreen extends StatefulWidget {
  const MusicsScreen({Key key}) : super(key: key);

  @override
  _MusicsScreenState createState() => _MusicsScreenState();
}

class _MusicsScreenState extends State<MusicsScreen> {
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
                            child: Text('Classical Musics',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MusicsList(type: 1)),
                            );
                          })),
                  SizedBox(
                      width: 300.0,
                      height: 800.0,
                      child: ListTile(
                          tileColor: Colors.lightBlue[700],
                          // title: Text(notes[index]['id']),
                          title: Center(
                            child: Text('Pop Musics',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MusicsList(type: 2)),
                            );
                          })),
                  SizedBox(
                      width: 300.0,
                      height: 800.0,
                      child: ListTile(
                          tileColor: Colors.lightBlue[800],
                          // title: Text(notes[index]['id']),
                          title: Center(
                            child: Text('Jazz Musics',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MusicsList(type: 3)),
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
    var notes = await DatabaseHelper.instance.getAllMusics();
    var dd = await DatabaseHelper.instance.getAllUsers();
    print(notes);
    print(dd);
  }
}
