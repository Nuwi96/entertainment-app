import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/db/database_helper.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonsList extends StatefulWidget {
  const LessonsList({Key key, int grade}) : super(key: key);

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
  final CollectionReference _lessons = FirebaseFirestore.instance.collection('lessons');
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
    //     body: StreamBuilder(
    //       stream:_lessons.snapshots() ,
    //       builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
    //         if(streamSnapshot.hasData){
    //           return Center(
    //               child:
    //               Column(mainAxisAlignment: MainAxisAlignment.center, children: <
    //                   Widget>[
    //                 const Text(
    //                   'list of lessons',
    //                 ),
    //                 Padding(
    //                   // fromLTRB(right, bottom, left, top)
    //                   padding: const EdgeInsets.fromLTRB(12, 2, 12, 3),
    //                   child: TextField(
    //                     autofocus: false,
    //                     controller: searchController,
    //                     cursorColor: Colors.white,
    //                     decoration: InputDecoration(
    //                         hintText: " Search...",
    //                         // border: InputBorder.none,
    //                         suffixIcon: IconButton(
    //                           icon: Icon(Icons.search),
    //                           color: Color.fromRGBO(93, 25, 72, 1),
    //                           onPressed: () {
    //                             search();
    //                           },
    //                         )),
    //                     style: TextStyle(color: Colors.black, fontSize: 15.0),
    //                     onChanged: (content) {
    //                       print(searchController.text);
    //                       search();
    //                     },
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: ListTileTheme(
    //                     contentPadding: EdgeInsets.all(15),
    //                     iconColor: Colors.white,
    //                     textColor: Colors.black54,
    //                     // tileColor: Colors.lightBlue[colorCode[index]],
    //                     style: ListTileStyle.list,
    //                     dense: true,
    //                     child: ListView.builder(
    //
    //                       keyboardDismissBehavior:
    //                       ScrollViewKeyboardDismissBehavior.onDrag,
    //                       scrollDirection: Axis.vertical,
    //                       shrinkWrap: true,
    //                       physics: ScrollPhysics(),
    //                       itemCount: searchController.text.isNotEmpty
    //                           ? searchNotes?.length ?? 0
    //                           : streamSnapshot.data.docs.length,
    //                       // itemCount:searchController.text.isNotEmpty?searchNotes?.length??0 : notes?.length ?? 0,
    //                       itemBuilder: (_, index) {
    //                         final DocumentSnapshot documentSnapshot = streamSnapshot.data.docs[index];
    //                         Card(
    //
    //                             margin: EdgeInsets.all(10),
    //                             child: ListTile(
    //                             tileColor: Colors.lightBlue[
    //                             colorCode[(index >= 3 ? colorCode.length - 1 : index)]],
    //                         // title: Text(notes[index]['id']),
    //                         title: Text(
    //                         documentSnapshot['lesson_title'],
    //                         style:
    //                         const TextStyle(color: Colors.white, fontSize: 18)),
    //                         subtitle: Text(documentSnapshot['lesson'],
    //                               style:
    //                               const TextStyle(color: Colors.white, fontSize: 15)),
    //
    //                           trailing: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             children: [
    //                               IconButton(
    //                                   onPressed: () async {
    //                                     setData(documentSnapshot['id'].toString(),
    //                                         documentSnapshot['lesson_title'], documentSnapshot['lesson']);
    //                                     showForm(context);
    //                                   },
    //                                   icon: const Icon(Icons.remove_red_eye)),
    //                             ],
    //                           ),
    //                         ),
    //                       );
    // }
    //                     ),
    //                   ),
    //                 ),
    //               ]));
    //             ListView.builder(
    //               itemCount: streamSnapshot.data.docs.length,
    //               itemBuilder:(context, index){
    //                 final DocumentSnapshot documentSnapshot = streamSnapshot.data.docs[index];
    //                 return Card(
    //                   child: Container(
    //                     child: Column(
    //                       children: [
    //                         Text(documentSnapshot['lesson_title']),
    //                         Text(documentSnapshot['lesson']),
    //                         Text(documentSnapshot['grade'].toString()),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               }
    //           );
    //         }
    //       },
    //
    //     ),
      body: StreamBuilder(
        stream:_lessons.snapshots() ,
        builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
                itemCount: streamSnapshot.data.docs.length,
                itemBuilder:(context, index){
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data.docs[index];
                  return Card(
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: Colors.lightBlue[
                            colorCode[(index >= 3 ? colorCode.length - 1 : index)]],
                            // title: Text(notes[index]['id']),
                            title: Text(documentSnapshot['lesson_title'],
                                style:
                                const TextStyle(color: Colors.white, fontSize: 18)),
                            subtitle: Text(documentSnapshot['lesson'],
                                style:
                                const TextStyle(color: Colors.white, fontSize: 15)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      // setData(notes[index]['id'].toString(),
                                      //     notes[index]['lesson_title'], notes[index]['lesson']);
                                      setData(documentSnapshot['id'],
                                          documentSnapshot['lesson_title'], documentSnapshot['lesson']);
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
                }
            );
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
                      decoration:
                          const InputDecoration(hintText: "Enter Title"),
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
  getData() async {
    setState(() async {
      notes = await DatabaseHelper.instance.getAllLessons();
    });
    print(notes);
  }

  search() async {
    setState(() {
      var text = searchController.text.toLowerCase();
      searchNotes = notes.where((element) {
        var title =element['lesson_title'].toString().toLowerCase();
        return title.contains(text);
      }).toList();
    });
  }
}
