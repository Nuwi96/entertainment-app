import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/ui/home_screen.dart';
import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController editUserNameController = TextEditingController();
  TextEditingController editPasswordController = TextEditingController();

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
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: const Color(0xff00008B),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text((!userArray[0]['logged_in'] ? 'ADMIN LOGIN' : 'ADMIN SIGNOUT'),
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w900)),
          !userArray[0]['logged_in']
              ? Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: editUserNameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          hintText: 'UserName',
                          labelText: 'UserName *',
                        ),
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String value) {
                          return (value != null)
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: editPasswordController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          hintText: 'Password',
                          labelText: 'Password *',
                        ),
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String value) {
                          return (value != null)
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              save();
                            },
                            child: const Text('Submit'),
                          )),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      logOut();
                    },
                    child: const Text('LogOut'),
                  )),
        ])));
  }

  save() async => {
        if ('' != editUserNameController.text &&
            '' != editPasswordController.text)
          {
            for (int i = 0; i < userArray.length; i++)
              {
                if ((editUserNameController.text == userArray[i]['user']) &&
                    (int.parse(editPasswordController.text) ==
                        userArray[i]['password']))
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
