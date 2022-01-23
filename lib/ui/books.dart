import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'books_list.dart';

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
          CarouselSlider(
            items: [
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[600],
                      title: Center(
                        child: Text('Grade 01',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 1)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[700],
                      // title: Text(notes[index]['id']),
                      title: Center(
                        child: Text('Grade 02',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 2)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[800],
                      // title: Text(notes[index]['id']),
                      title: Center(
                        child: Text('Grade 03',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 3)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[900],
                      // title: Text(notes[index]['id']),
                      title: Center(
                        child: Text('Grade 04',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 4)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[600],
                      // title: Text(notes[index]['id']),
                      title: Center(
                        child: Text('Grade 05',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 5)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[700],
                      // title: Text(notes[index]['id']),
                      title: Center(
                        child: Text('Grade 06',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 6)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[800],
                      // title: Text(notes[index]['id']),
                      title: const Center(
                        child: Text('Grade 07',
                            style: TextStyle(
                                color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 7)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[900],
                      // title: Text(notes[index]['id']),
                      title: const Center(
                        child: Text('Grade 08',
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 8)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[600],
                      // title: Text(notes[index]['id']),
                      title: const Center(
                        child: Text('Grade 09',
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 9)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[700],
                      // title: Text(notes[index]['id']),
                      title: const Center(
                        child: Text('Grade 10',
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 10)),
                        );
                      })),
              SizedBox(
                  width: 300.0,
                  height: 800.0,
                  child: ListTile(
                      tileColor: Colors.lightBlue[800],
                      // title: Text(notes[index]['id']),
                      title: const Center(
                        child: Text('Grade 11',
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LessonsList(grade: 11)),
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
    var notes = await DatabaseHelper.instance.getAllLessons();
    var dd = await DatabaseHelper.instance.getAllUsers();
    print(notes);
    print(dd);
  }
}
