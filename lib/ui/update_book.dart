import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'add_book.dart';
import 'lessons.dart';

class UpdateBook extends StatefulWidget {
  final data;
  final id;

  const UpdateBook({Key key, this.data, this.id}) : super(key: key);

  @override
  _UpdateBookState createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  final CollectionReference _lessons =
      FirebaseFirestore.instance.collection('lessons');
  String title;
  String author;
  String year;
  String desc;
  String image;
  String grade = '1';

  @override
  void initState() {
    super.initState();
    setState(() {
      title = widget.data['title'];
      author = widget.data['author'];
      year = widget.data['published_year'];
      desc = widget.data['description'];
      image = widget.data['image'];
      grade = widget.data['grade'].toString();
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
                "Update Book,",
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
                textInputAction: TextInputAction.next,
                autoFocus: true,
              ),
              SizedBox(height: screenHeight * .025),
              InputField(
                onChanged: (value) {
                  setState(() {
                    author = value;
                  });
                },
                value: author,
                labelText: "Author",
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
                    year = value;
                  });
                },
                value: year,
                labelText: "Published Year",
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
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '10',
                  '11'
                ].map((String value) {
                  return new DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text('Grade ' + value),
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  // do other stuff with _category
                  setState(() => grade = newValue);
                },
                value: grade,
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
                text: "Update Book",
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
    _lessons.doc(widget.id).update({
      "title": title,
      "author": author,
      "published_year": year,
      "description": desc,
      "image": image,
      "grade": int.parse(grade),
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LessonsScreen()),
    );
    Toast.show("Book Updated Successfully", context,
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