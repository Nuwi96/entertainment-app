import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonsList extends StatefulWidget {
  final int grade;

  const LessonsList({Key key, this.grade}) : super(key: key);

  @override
  _LessonsListState createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _lessons.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      var a = allData[i]['grade'];
      if (widget.grade == a) {
        gradeArray.add(allData[i]);
        // print(allData[i]);
      }
      print(gradeArray);
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
                                // title: Text(notes[index]['id']),
                                title: Text(gradeArray[index]['lesson_title'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                subtitle: Text(gradeArray[index]['lesson'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          // final String title = gradeArray[index]['lesson'];
                                          // var lesson = documentSnapshot['lesson'];
                                          //
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) => const LessonView(title:title,gradeArray[index]['lesson_title'])),
                                          // );

                                          setData(
                                              gradeArray[index]['id']
                                                  .toString(),
                                              gradeArray[index]['lesson_title'],
                                              gradeArray[index]['lesson']);
                                          // setData(documentSnapshot['id'],
                                          //     documentSnapshot['lesson_title'], documentSnapshot['lesson']);
                                          showForm(context);
                                        },
                                        icon: const Icon(Icons.remove_red_eye)),
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

  Future<void> showForm(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: false,
                    child: TextFormField(controller: editIDController),
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: editTitleController,
                    validator: (value) {
                      return value.isNotEmpty ? null : "Invalid Filed";
                    },
                    decoration: const InputDecoration(hintText: "Enter Title"),
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: editNoteController,
                    maxLines: 6,
                    validator: (value) {
                      return value.isNotEmpty ? null : "Invalid Filed";
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter Description"),
                  )
                ],
              ),
            ),
          );
        }).then((_) => setState(() {
          // getData();
        }));
  }

  setData(id, title, note) {
    if ('' != id) {
      editIDController.text = id;
      editTitleController.text = title;
      editNoteController.text = note;
    } else {
      editIDController.text = '';
      editTitleController.text = '';
      editNoteController.text = '';
    }
  }

  // getData() async {
  //   setState(() async {
  //     notes = await DatabaseHelper.instance.getAllLessons();
  //   });
  //   print(notes);
  // }

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
