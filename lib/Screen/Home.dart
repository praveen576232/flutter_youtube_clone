import 'package:flutter/material.dart';

import 'package:youtube/Screen/Homepage.dart';
import 'package:youtube/Screen/Library.dart';
import 'package:youtube/Screen/Subscriptions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int currenttab = 0;
List<Widget> tabs = [
  HomePage(),
  HomePage(),
  Subscriptions(),
  HomePage(),
  Library()
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currenttab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currenttab,
        showUnselectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(

              icon: Icon(Icons.explore),
              title: Text(
                "Explore",
                style: TextStyle(fontSize: 12),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), title: Text("Subscriptions", style: TextStyle(fontSize: 12),)),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text("Notifications", style: TextStyle(fontSize: 12),)),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), title: Text("Library", style: TextStyle(fontSize: 12),)),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currenttab = index;
            print(index);
          });
        },
      ),
    );
  }
}
