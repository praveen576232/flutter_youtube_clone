import 'package:flutter/material.dart';
import 'package:youtube/Screen/search/search.dart';

Widget appbar(BuildContext context) {
  return SliverAppBar(
    backgroundColor: Colors.white,
    bottom: PreferredSize(
        child: Container(
          height: 1,
          color: Colors.grey,
        ),
        preferredSize: Size.fromHeight(4.0)),
    title: Image.asset(
      'assert/logo.png',
      fit: BoxFit.fill,
      width: 100,
    ),
    actions: [
      IconButton(
          icon: Icon(
            Icons.videocam,
            color: Colors.grey,
          ),
          onPressed: () {}),
      IconButton(
          icon: Icon(Icons.search, color: Colors.grey),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionsBuilder:
                    (context, animation1, animation2, widgetchild) {
                  return SizeTransition(
                    sizeFactor: animation1,
                    child: widgetchild,
                  );
                },
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation1, animation2) {
                  return Search();
                }));
          }),
      Padding(
          padding: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            maxRadius: 12.0,
          ))
    ],
  );
}
