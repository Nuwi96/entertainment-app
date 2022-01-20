import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'lessonsList.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key key}) : super(key: key);

  @override
  _LessonsScreenState createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
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
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
          const Text(
            'lesons',
          ),
          CarouselSlider(
            items: [
              ListTile(
                  tileColor: Colors.lightBlue[600],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 01',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    print('01');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LessonsList(grade:1)),
                    );
                  }),
              ListTile(
                  tileColor: Colors.lightBlue[700],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 02',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15)),
                  onTap: () {
                    print('02');
                  }),
              ListTile(
                  tileColor: Colors.lightBlue[800],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 03',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[900],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 04',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[600],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 05',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[700],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 06',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[800],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 07',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[900],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 08',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[600],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 09',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[700],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 10',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
              ListTile(
                  tileColor: Colors.lightBlue[800],
                  // title: Text(notes[index]['id']),
                  title: Text('Grade 11',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  subtitle: Text('BBB',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15))),
            ],
            //Slider Container properties
            options: CarouselOptions(
              autoPlay: true,
            ),
          )
        ])));
  }

  getData() async {
    var notes = await DatabaseHelper.instance.getAllLessons();
    var dd = await DatabaseHelper.instance.getAllUsers();
    print(notes);
    print(dd);
  }
}
