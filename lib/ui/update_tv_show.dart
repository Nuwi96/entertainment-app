import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:education_app/ui/tv_list_view.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';
import 'books.dart';

class UpdateTvShowScreen extends StatefulWidget {
  final data;
  final id;
  final type;

  const UpdateTvShowScreen({Key key, this.data, this.id, this.type}): super(key: key);

  @override
  _UpdateTvShowScreenState createState() => _UpdateTvShowScreenState();
}

class _UpdateTvShowScreenState extends State<UpdateTvShowScreen> {
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
    // print(widget.data);
    setState(() {
      name = widget.data['name'];
      overview = widget.data['overview'];
      popularity = widget.data['popularity'].toString();
      backdrop_path = widget.data['backdrop_path'];
      id = widget.data['id'];
      type = widget.type;
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
                "Update Tv Show,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              InputField(
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
              InputField(
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
              InputField(
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
              InputField(
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
                text: "Update Tv Show",
                onPressed: update,
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
            ],
          )),
    );
  }

  update() {
    switch (type) {
      case 'tv_shows':
        _shows.doc(widget.id).update({
          "name": name,
          "overview": overview,
          "popularity": double.parse(popularity),
          "backdrop_path": backdrop_path,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
        );
        Toast.show("Tv Show Updated Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        break;
      case 'on_air_tv_shows':
        _on_air_shows.doc(widget.id).update({
          "name": name,
          "overview": overview,
          "popularity": double.parse(popularity),
          "backdrop_path": backdrop_path,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
        );
        Toast.show("Tv Show Updated Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        break;
      case 'tv_top_rated':
        _top_rated_shows.doc(widget.id).update({
          "name": name,
          "overview": overview,
          "popularity": double.parse(popularity),
          "backdrop_path": backdrop_path,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TvShowListView(type: type)),
        );
        Toast.show("Tv Show Updated Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green);
        break;
    }
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const FormButton({this.text = "", this.onPressed, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed as void Function(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String errorText;
  final String value;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final bool obscureText;

  const InputField(
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
      controller: TextEditingController(text: value),
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
