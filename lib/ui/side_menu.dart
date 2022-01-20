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
          const DrawerHeader(
              child: Text(
                'EDU',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Color(0xff00008B),
              )
          ),
          ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              )
            },
          ),ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Lessons'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LessonsScreen()),
              )
            },
          ),ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Tuition'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TuitionScreen()),
              )
            },
          ),ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add Lesson'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddLesson()),
              )
            },
          ),ListTile(
            leading: const Icon(Icons.house_sharp),
            title: const Text('Add Advertisement'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAdvertisement()),
              )
            },
          ),
        ],
      ),
    );
  }
}