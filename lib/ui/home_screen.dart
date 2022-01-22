import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:education_app/ui/tv_shows_popular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lessons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('login_user');

  var userArray = [];
  var item = [
    {
      "name": "Movies",
      "image": "assets/images/movie - Copy.jpg",
      "screen": "",
    },
    {
      "name": "Book",
      "image": "assets/images/book - Copy.jpg",
      "screen": LessonsScreen(),
    },
    {
      "name": "Tv Shows",
      "image": "assets/images/tv - Copy.jpg",
      "screen": TvShows(),
    }
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _users.get();

    setState(() {
      userArray = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xff00008B),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(
          item.length,
          (index) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  item[index]['screen']),
                  );
            },
            child :
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.50),
                              BlendMode.dstATop),
                          image: new AssetImage(item[index]['image']),
                          fit: BoxFit.cover,
                        ),
                      ),

                    ),
                    new Center(
                      child: new Text(
                        item[index]['name'],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],

                )));
          },
        ),
      ),

      // Center(
      //   child: Text(!userArray[0]['logged_in'] ? 'Welcome To EDU APP' : 'Welcome ADMIN ', style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.6))),
      // )
    );
  }
}
