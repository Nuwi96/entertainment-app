import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';
import 'lessons.dart';

class AddBookScreen extends StatefulWidget {
  final Function(String email, String password) onSubmitted;

  const AddBookScreen({this.onSubmitted, Key key}) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  String title;
  String author;
  String year;
  String desc;
  String image;
  String grade = '1';
  final CollectionReference _lessons =
      FirebaseFirestore.instance.collection('lessons');

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
            children: [
              SizedBox(height: screenHeight * .025),
              const Text(
                "Add New Book,",
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
                // onSubmitted: (val) => submit(),
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
                // onSubmitted: (val) => submit(),
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
                // onSubmitted: (val) => submit(),
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
                          Text('Grade '+ value),
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
                text: "Save Book",
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
        if ('' != title && 0 != author)
          {
            Toast.show("Added Successfully", context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM,
                backgroundColor: Colors.green),
            await _lessons.add({
              "title": title,
              "grade": int.parse(grade),
              "description": desc,
              "image": image,
              "published_year": year,
              "author": author,
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

  logOut() => {
        _users.doc('ljipn32D6ddiSuE3rVXm').update({"logged_in": false}),
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        ),
        Toast.show("Admin User Log Out Successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.green),
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

class InputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String errorText;
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
      this.autoFocus = false,
      this.obscureText = false,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
