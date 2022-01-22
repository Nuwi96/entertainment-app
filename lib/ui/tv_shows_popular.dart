import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TvShows extends StatefulWidget {
  const TvShows({Key key}) : super(key: key);

  @override
  _TvShowsState createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  final CollectionReference _tv_shows =
  FirebaseFirestore.instance.collection('tv_top_rated');

  Map tvShows = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    getData();

  }

  getData() async {

    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=66ed895e7cd5320bdb1a8245e2a25f6a&language=en-US&page=1'));
        // 'https://api.themoviedb.org/3/tv/popular?api_key=66ed895e7cd5320bdb1a8245e2a25f6a&language=en-US&page=1'));
    try {
      setState(() {
        tvShows = jsonDecode(response.body);
      });
      print(tvShows);
       setData();
    } catch (e) {
      return 'failed';
    }
  }


  Future<void> setData() async {
    QuerySnapshot querySnapshot = await _tv_shows.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(tvShows['results'].length);

    for (int i = 0; i < tvShows['results'].length; i++) {
      print(      tvShows['results'][i]
      );
      // await _tv_shows.add({
      //   "backdrop_path": tvShows['results'][i]['backdrop_path'],
      //   "popularity": tvShows['results'][i]['popularity'],
      //   "name": tvShows['results'][i]['original_name'],
      //   "overview": tvShows['results'][i]['overview'],
      //   "id": tvShows['results'][i]['id'],
      // });


      // if (a != tvShows['results'][i]['id']) {
      //   _tv_shows.add({
      //     "backdrop_path": tvShows['results'][i]['backdrop_path'],
      //     "popularity": tvShows['results'][i]['popularity'],
      //     "name": tvShows['results'][i]['name'],
      //     "overview": tvShows['results'][i]['overview'],
      //     "id": tvShows['results'][i]['id'],
      //   });
      // }else{
      //   print('duplicate');
      // }

      // allData[i]['doc_id'] = querySnapshot.docs[i].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Color(0xff00008B),
        ),
        body: Center());
  }
}
