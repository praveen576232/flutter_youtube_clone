import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youtube/Screen/AppBar.dart';
import 'package:youtube/Screen/Play_Video.dart';
import 'package:youtube/Screen/Video_Container/Video_Container.dart';
import 'package:youtube/Screen/search/search.dart';
import 'package:youtube/dummydata/video.dart';
import 'package:youtube/functions/showBottom.dart';
import 'package:youtube/youtube_api/request.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    load_home_screen_page();
    super.initState();
  }

  Future load_home_screen_page() async {
    http.Response res = await http.get(home_page_video_end_point);
   
    if (res != null)
      return json.decode(res.body);
    else
      return null;
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: FutureBuilder(
          future: load_home_screen_page(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              print(snapshot.data);
              return CustomScrollView(
                slivers: [
                appbar(context),
                  SliverList(delegate:
                      SliverChildBuilderDelegate((bulidcontext, index) {
                    return Video_Container(
                      item: snapshot.data['items'][index],
                      isViewsCount: true,
                      onTapVideo: (item, channel) =>
                          showBottomSheetForVideo(item, channel, size,context),
                    );
                  }))
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
