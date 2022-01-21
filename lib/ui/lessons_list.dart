import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson_view.dart';

class LessonsList extends StatefulWidget {
  final int grade;

  const LessonsList({Key key, this.grade}) : super(key: key);

  @override
  _LessonsListState createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  List<Map<String, dynamic>> notes;
  List<Map<String, dynamic>> noteList;
  List<Map<String, dynamic>> searchNotes;
  int i = 0;
  final List<int> colorCode = [900, 700, 500];
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editNoteController = TextEditingController();
  TextEditingController editIDController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final CollectionReference _lessons =
      FirebaseFirestore.instance.collection('lessons');

  List gradeArray = [];
  String title;
  String article;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _lessons.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      var a = allData[i]['grade'];
      if (widget.grade == a) {
        gradeArray.add(allData[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xff00008B),
      ),
      body: StreamBuilder(
        stream: _lessons.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return gradeArray.isEmpty
                ? const Center(
                    child: Text('No Data To Display',
                        style: TextStyle(fontSize: 20)),
                  )
                : ListView.builder(
                    itemCount: gradeArray.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data.docs[index];
                      return Card(
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                tileColor: Colors.lightBlue[colorCode[
                                    (index >= 3
                                        ? colorCode.length - 1
                                        : index)]],
                                title: Text(gradeArray[index]['title']??'',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                subtitle: Text(gradeArray[index]['author']??'',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                leading: CircleAvatar(backgroundImage: NetworkImage(gradeArray[index]['image']??'')),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  LessonView(data:gradeArray[index])),
                                          );
                                        },
                                        icon: const Icon(Icons.remove_red_eye,color: Colors.white,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
          }
        },
      ),
    );
  }

  search() async {
    setState(() {
      var text = searchController.text.toLowerCase();
      searchNotes = notes.where((element) {
        var title = element['lesson_title'].toString().toLowerCase();
        return title.contains(text);
      }).toList();
    });
  }
}
