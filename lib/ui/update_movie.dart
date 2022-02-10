import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'books.dart';

class UpdateMovie extends StatefulWidget {
  final data;
  final id;

  const UpdateMovie({Key key, this.data, this.id}) : super(key: key);

  @override
  _UpdateMovieState createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {
  final CollectionReference _movies =
  FirebaseFirestore.instance.collection('movies');
  String title;
  String year;
  String population;
  String desc;
  String image;
  String types = '1';

  @override
  void initState() {
    super.initState();
    setState(() {
      title = widget.data['title'];
      year = widget.data['year'];
      population = widget.data['population'];
      desc = widget.data['description'];
      image = widget.data['image'];
      types = widget.data['types'].toString();
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
                "Update Movie,",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              InputField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                value: title,
                labelText: "Title",
                // textInputAction: TextInputAction.next,
                // autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    year = value;
                  });
                },
                value: year,
                labelText: "Year",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    desc = value;
                  });
                },
                value: desc,
                labelText: "Description",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    population = value;
                  });
                },
                value: population,
                labelText: "Population",
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    image = value;
                  });
                },
                value: image,
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
                          Text('Types ' + value),
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
                text: "Update Movie",
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
    _movies.doc(widget.id).update({
      "title": title,
      "year": year,
      "population": population,
      "description": desc,
      "image": image,
      "types": int.parse(types),
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LessonsScreen()),
    );
    Toast.show("Movie Updated Successfully", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green);
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
