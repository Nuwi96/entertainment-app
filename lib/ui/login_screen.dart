import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';

class SimpleLoginScreen extends StatefulWidget {
  final Function(String email, String password) onSubmitted;

  const SimpleLoginScreen({this.onSubmitted, Key key}) : super(key: key);

  @override
  _SimpleLoginScreenState createState() => _SimpleLoginScreenState();
}

class _SimpleLoginScreenState extends State<SimpleLoginScreen> {
  String username;
  String password;
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
        child: !userArray[0]['logged_in']
            ? ListView(
                children: [
                  SizedBox(height: screenHeight * .12),
                  const Text(
                    "Welcome,",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * .01),
                  Text(
                    "Sign in to continue!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  SizedBox(height: screenHeight * .12),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    labelText: "Username",
                    // errorText: emailError,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autoFocus: true,
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    // onSubmitted: (val) => submit(),
                    labelText: "Password",
                    // errorText: passwordError,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: screenHeight * .075,
                  ),
                  FormButton(
                    text: "Log In",
                    onPressed: save,
                  ),
                  SizedBox(
                    height: screenHeight * .15,
                  ),
                ],
              )
            : Center(
                child: ListView(
                children: [
                  SizedBox(height: screenHeight * .12),
                  const Text(
                    "LogOut,",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * .12),
                  FormButton(
                    text: "Log Out",
                    onPressed: logOut,
                  )
                ],
              )),
      ),
    );
  }

  save() async => {
        if ('' != username && 0 != password)
          {
            for (int i = 0; i < userArray.length; i++)
              {
                if ((username == userArray[i]['user']) &&
                    (int.parse(password) == userArray[i]['password']))
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    ),
                    _users
                        .doc('ljipn32D6ddiSuE3rVXm')
                        .update({"logged_in": true})
                  }
                else
                  {
                    Toast.show("Incorrect Credentials", context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM,
                        backgroundColor: Colors.red),
                  }
              }
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
