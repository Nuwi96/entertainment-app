import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TvShowListView extends StatefulWidget {
  String type;
   TvShowListView({Key key, this.type}) : super(key: key);

  @override
  _TvShowListViewState createState() => _TvShowListViewState(type);
}

class _TvShowListViewState extends State<TvShowListView> {
  String type;
  _TvShowListViewState(this.type);
  final CollectionReference _shows =
  FirebaseFirestore.instance.collection(type);

  final CollectionReference _users =
  FirebaseFirestore.instance.collection('login_user');

  var userArray = [];
  List showArray = [];

  String title;
  String article;



  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {


    QuerySnapshot querySnapshot = await _shows.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      print(querySnapshot.docs[i].id);
      var a = allData[i]['grade'];
        allData[i]['id'] = querySnapshot.docs[i].id;
        setState(() {
          showArray.add(allData[i]);
        });
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
        stream: _shows.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return showArray.isEmpty
                ? const Center(
              child: Text('No Data To Display',
                  style: TextStyle(fontSize: 20)),
            )
                : ListView.builder(
                itemCount: showArray.length,
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
                            title: Text(showArray[index]['title'] ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            subtitle: Text(
                                showArray[index]['author'] ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    showArray[index]['image'] ?? '')),
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
                                                    showArray[index])),
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
                                          showArray[index]['id']);
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
                                                    data: showArray[
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
}
