import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:education_app/ui/tv_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'add_book.dart';

class AddTvShow extends StatefulWidget {
  const AddTvShow({Key key}) : super(key: key);

  @override
  _AddTvShowState createState() => _AddTvShowState();
}

class _AddTvShowState extends State<AddTvShow> {
  final CollectionReference _shows =
      FirebaseFirestore.instance.collection('tv_shows');
  final CollectionReference _on_air_shows =
      FirebaseFirestore.instance.collection('on_air_tv_shows');
  final CollectionReference _top_rated_shows =
      FirebaseFirestore.instance.collection('tv_top_rated');
  String name;
  String overview;
  String popularity;
  String backdrop_path;
  String id;
  String type;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = '';
      overview = '';
      popularity = '';
      backdrop_path = '';
      id = '';
      type = 'tv_shows';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: const Color(0xff00008B),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * .025),
              const Text(
                "Add Tv Show,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                value: name,
                labelText: "Name",
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    overview = value;
                  });
                },
                value: overview,
                labelText: "Overview",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    backdrop_path = value;
                  });
                },
                value: backdrop_path,
                labelText: "Image URL",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    popularity = value;
                  });
                },
                value: popularity,
                labelText: "popularity",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              DropdownButtonFormField(
                items: <String>[
                  'tv_shows',
                  'on_air_tv_shows',
                  'tv_top_rated',
                ].map((String value) {
                  return new DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text(value),
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(() => type = newValue);
                },
                value: type,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  filled: true,
                  fillColor: Colors.white,
                  // hintText: Localization.of(context).category,
                ),
              ),
              SizedBox(
                height: screenHeight * .025,
              ),
              FormButton(
                text: "Save Tv Show",
                onPressed: save,
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
            ],
          )),
    );
  }

  save() {
    if ('' != name && '' != overview) {
      switch (type) {
        case 'tv_shows':
          _shows.add({
            "name": name,
            "overview": overview,
            "popularity": ('' !=popularity)?double.parse(popularity):0,
            "backdrop_path": backdrop_path,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
          );
          Toast.show("Tv Show Added Successfully", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.green);
          break;
        case 'on_air_tv_shows':
          _on_air_shows.add({
            "name": name,
            "overview": overview,
            "popularity": ('' !=popularity)?double.parse(popularity):0,
            "backdrop_path": backdrop_path,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
          );
          Toast.show("Tv Show Added Successfully", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.green);
          break;
        case 'tv_top_rated':
          _top_rated_shows.add({
            "name": name,
            "overview": overview,
            "popularity": ('' !=popularity)?double.parse(popularity):0,
            "backdrop_path": backdrop_path,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
          );
          Toast.show("Tv Show Added Successfully", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM,
              backgroundColor: Colors.green);
          break;
      }
    } else {
      Toast.show("Please fill all the fields", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
    }
  }
}

class TextInputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String errorText;
  final String value;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final bool obscureText;

  const TextInputField(
      {this.labelText,
      this.onChanged,
      this.onSubmitted,
      this.errorText,
      this.keyboardType,
      this.textInputAction,
      this.value,
      this.autoFocus = false,
      this.obscureText = false,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: labelText,
        errorText: errorText,
        // hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
