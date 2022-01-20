import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _lessons = FirebaseFirestore.instance.collection('lessons');
  // final CollectionReference _lessons = FirebaseFirestore.instance.collection('lessons').where(
  //     {
  //       "grade":'1'
  //     });
  // final _lessons = FirebaseFirestore.instance.collection('lessons').where(
  //     'grade', isEqualTo: '1');


  void _incrementCounter() {
    setState(() {
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
                         Text(documentSnapshot['lesson_title']),
                         Text(documentSnapshot['lesson']),
                         Text(documentSnapshot['grade'].toString()),
                       ],
                     ),
                  ),
                );
                }
            );
          }
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(
          Icons.add
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
