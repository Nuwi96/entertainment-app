import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonView extends StatefulWidget {
  final data;

  const LessonView({Key key, this.data}) : super(key: key);

  @override
  _LessonViewState createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xff00008B),
      ),
      body: Container(
        // child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  //leading: Icon(Icons.music_note),
                  title: Text(widget.data['title'],style: const TextStyle(
                      fontSize: 18,fontWeight: FontWeight.w300)),
                ),
                elevation: 8,
                shadowColor: Colors.lightBlueAccent,
                margin: EdgeInsets.all(5),
              ),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.data['image']),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shadowColor: Colors.lightBlueAccent,
                child: Column(
                  children: [
                    Text('Author :' +  widget.data['author'],style: const TextStyle(
                    fontSize: 15,fontWeight: FontWeight.w900)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.data['description'],
                        style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
