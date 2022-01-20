import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'lessons.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({Key key}) : super(key: key);

  @override
  _AddLessonState createState() => _AddLessonState();
}

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class _AddLessonState extends State<AddLesson> {
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();
  final CollectionReference _lessons =
      FirebaseFirestore.instance.collection('lessons');
  List<Item> users = <Item>[
    const Item(
        'Grade 01',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 02',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 03',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 04',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 05',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 06',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 07',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 08',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 09',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 10',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Grade 11',
        Icon(
          Icons.crop_square,
          color: const Color(0xFF167F67),
        )),
  ];
  Item selectedUser = const Item(
      '',
      Icon(
        Icons.crop_square,
        color: const Color(0xFF167F67),
      ));

  String _selectedText = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: const Color(0xff00008B),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Add a Lesson',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w900)),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: editTitleController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: 'Article Title',
                    labelText: 'Title *',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return (value != null) ? 'Do not use the @ char.' : null;
                  },
                ),
                TextFormField(
                  controller: editDescriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.content_paste),
                    hintText: 'Article Content',
                    labelText: 'Content *',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return (value != null) ? 'Do not use the @ char.' : null;
                  },
                ),
                // DropdownButton<Item>(
                //   hint: Text("Select Grade"),
                //   // value: selectedUser.name,
                //   onChanged: (event) {
                //     setState(() {
                //       selectedUser = Value;
                //     });
                //   },
                //   items: users.map((Item user) {
                //     return DropdownMenuItem<Item>(
                //       value: user,
                //       child: Row(
                //         children: <Widget>[
                //           user.icon,
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Text(
                //             user.name,
                //             style: TextStyle(color: Colors.black),
                //           ),
                //         ],
                //       ),
                //     );
                //   }).toList(),
                // ),
                Center(
                    child: Container(
                        width: 300,
                        child: DropdownButton<String>(
                          hint: Text("Status"),
                          value: _selectedText,
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              _selectedText = val;
                            });
                            print(_selectedText);
                          },
                        ))),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        save();
                      },
                      child: const Text('Submit'),
                    )),
              ],
            ),
          )
        ])));
  }

  save() async => {
        // print(    selectedUser.name
        // ),
        if ('' != editDescriptionController.text &&
            '' != editTitleController.text &&
            '' != _selectedText)
          {
            await DatabaseHelper.instance.insertLesson({
              "lesson_title": editTitleController.text,
              "grade": int.parse(_selectedText),
              "lesson": editDescriptionController.text,
              "added_user": 1,
            }),
            Toast.show("Added Successfully", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green),
            await _lessons.add({
              "lesson_title": editTitleController.text,
              "lesson": editDescriptionController.text,
              "grade": int.parse(_selectedText),
              "added_user": '1'
            }),
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LessonsScreen()),
            )
          }
        else
          {
            Toast.show("Please fill all the fields", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.red),
          }
      };
}
