import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';
import 'books.dart';

class AddMovieScreen extends StatefulWidget {
  final Function(String email, String password) onSubmitted;

  const AddMovieScreen({this.onSubmitted, Key key}) : super(key: key);

  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  String title;
  String popularity;
  String year;
  String desc;
  String image;
  String types = '1';
  final CollectionReference _movies =
  FirebaseFirestore.instance.collection('movies');

  final CollectionReference _users =
  FirebaseFirestore.instance.collection('login_user');

  var userArray = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
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
        backgroundColor: const Color(0xff00008B),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              SizedBox(height: screenHeight * .025),
              const Text(
                "Add New Movie,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                labelText: "Title",
                textInputAction: TextInputAction.next,
                // autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    popularity = value;
                  });
                },
                // onSubmitted: (val) => submit(),
                labelText: "Popularity",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    desc = value;
                  });
                },
                // onSubmitted: (val) => submit(),
                labelText: "Description",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    year = value;
                  });
                },
                // onSubmitted: (val) => submit(),
                labelText: "Year",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              TextInputField(
                onChanged: (value) {
                  setState(() {
                    image = value;
                  });
                },
                // onSubmitted: (val) => submit(),
                labelText: "Image URL",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: screenHeight * .025,
              ),
              DropdownButtonFormField(
                items: <String>[
                  '1',
                  '2',
                  '3'
                ].map((String value) {
                  return new DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text('Movie type ' + value),
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(() => types = newValue);
                },
                value: types,
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
                text: "Save Movie",
                onPressed: save,
              ),
              SizedBox(
                height: screenHeight * .15,
              ),
            ],
          )),
    );
  }

  save() async => {
    if (null != title && null != popularity)
      {
        Toast.show("Added Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green),
        await _movies.add({
          "title": title,
          "types": int.parse(types),
          "description": desc,
          "image": image,
          "year": year,
          "popularity": popularity,
          "added_user": 1,
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
