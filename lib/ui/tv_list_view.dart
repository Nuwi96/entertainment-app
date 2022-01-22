import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:education_app/ui/tv_show_view.dart';
import 'package:education_app/ui/update_tv_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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
      FirebaseFirestore.instance.collection('tv_shows');
  final CollectionReference _on_air_shows =
      FirebaseFirestore.instance.collection('on_air_tv_shows');
  final CollectionReference _top_rated_shows =
      FirebaseFirestore.instance.collection('tv_top_rated');
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('login_user');

  var userArray = [];
  List showArray = [];
  final List<int> colorCode = [900, 700, 500];
  String title;
  String article;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    switch (type) {
      case 'tv_shows':
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
        break;
      case 'on_air_tv_shows':
        QuerySnapshot querySnapshot = await _on_air_shows.get();

        final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

        for (int i = 0; i < allData.length; i++) {
          print(querySnapshot.docs[i].id);
          var a = allData[i]['grade'];
          allData[i]['id'] = querySnapshot.docs[i].id;
          setState(() {
            showArray.add(allData[i]);
          });
        }
        break;
      case 'tv_top_rated':
        QuerySnapshot querySnapshot = await _top_rated_shows.get();

        final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

        for (int i = 0; i < allData.length; i++) {
          print(querySnapshot.docs[i].id);
          var a = allData[i]['grade'];
          allData[i]['id'] = querySnapshot.docs[i].id;
          setState(() {
            showArray.add(allData[i]);
          });
        }
        break;
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
                                title: Text(showArray[index]['name'] ?? '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                subtitle: Text(
                                    'Popularity ' +
                                            showArray[index]['popularity']
                                                .toString() ??
                                        '',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://image.tmdb.org/t/p/original' +
                                                showArray[index]
                                                    ['backdrop_path'] ??
                                            '')),
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
                                                    TvShowView(
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
                                                        UpdateTvShowScreen(
                                                            data: showArray[
                                                                index],
                                                            id: streamSnapshot
                                                                .data
                                                                .docs[index]
                                                                .id,
                                                            type: widget.type)),
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
      onPressed: () async {
        switch (type) {
          case 'tv_shows':
            _shows.doc(id).delete();
            Toast.show("Deleted Successfully", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green);
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TvShowListView(type: 'tv_shows')),
            );
            break;
          case 'on_air_tv_shows':
            _on_air_shows.doc(id).delete();
            Toast.show("Deleted Successfully", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green);
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TvShowListView(type: 'on_air_tv_shows')),
            );
            break;
          case 'tv_top_rated':
            _top_rated_shows.doc(id).delete();
            Toast.show("Deleted Successfully", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green);
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TvShowListView(type: 'tv_top_rated')),
            );
            break;
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are You Sure...?"),
      content: Text(
          "Would you like to continue deleting this Tv Show...? You can't revert this action again."),
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
