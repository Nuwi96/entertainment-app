import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:education_app/ui/update_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('login_user');

  var userArray = [];
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
      print(querySnapshot.docs[i].id);
      var a = allData[i]['grade'];
      if (widget.grade == a) {
        allData[i]['id'] = querySnapshot.docs[i].id;
        setState(() {
          gradeArray.add(allData[i]);
        });
      }
    }

    QuerySnapshot querySnapshot2 = await _users.get();

    setState(() {
      userArray = querySnapshot2.docs.map((doc) => doc.data()).toList();
    });
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
                                title: Text(gradeArray[index]['title'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                subtitle: Text(
                                    gradeArray[index]['author'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        gradeArray[index]['image'] ?? '')),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(streamSnapshot
                                    //     .data.docs[index].id),
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonView(
                                                        data:
                                                            gradeArray[index])),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        )),
                                    userArray[0]['logged_in']
                                        ? IconButton(
                                            onPressed: () async {
                                              showAlertDialog(context,
                                                  gradeArray[index]['id']);
                                              // delete(streamSnapshot.data.docs[index].id);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ))
                                        : Text(''),
                                    userArray[0]['logged_in']
                                        ? IconButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateBook(
                                                            data: gradeArray[
                                                                index],
                                                            id: streamSnapshot
                                                                .data
                                                                .docs[index]
                                                                .id)),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ))
                                        : Text(''),
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

  showAlertDialog(BuildContext context, id) {
    print(id);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        _lessons.doc(id).delete();
        Toast.show("Deleted Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LessonsList(grade: widget.grade)),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are You Sure...?"),
      content: Text(
          "Would you like to continue deleting this book...? You can't revert this action again."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
