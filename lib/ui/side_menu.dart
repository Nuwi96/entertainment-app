import 'package:education_app/ui/tution.dart';
import 'package:flutter/material.dart';

import 'add_advertisement.dart';
import 'add_lesson.dart';
import 'home_screen.dart';
import 'lessons.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.75), BlendMode.dstATop),
                    image: AssetImage('assets/images/note.jpg'),

                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              )),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Books'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LessonsScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Tuition Advertisement'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TuitionScreen()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add a book'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddLesson()),
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add Advertisement'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddAdvertisement()),
              )
            },
          ),
        ],
      ),
    );
  }
}
