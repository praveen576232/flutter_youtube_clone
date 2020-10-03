import 'package:flutter/material.dart';
import 'package:youtube/Screen/AppBar.dart';
import 'package:youtube/Screen/Video_Container/Video_Container.dart';
import 'package:youtube/dummydata/subscriber.dart';
import 'package:youtube/dummydata/video.dart';
import 'package:youtube/functions/showBottom.dart';
import 'package:youtube/functions/text_trimmer.dart';

class Subscriptions extends StatefulWidget {
  @override
  _SubscriptionsState createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  var videos;
  var subscriber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videos = video;
    subscriber = sub;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Widget sublist() {
      return subscriber != null
          ? Container(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    child: ListView.builder(
                        itemCount: subscriber['items'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  maxRadius: 28.0,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(subscriber['items'][index]['snippet']['thumbnails']['high']['url']),
                                ),
                              ),
                              Text(stringtrimmer(subscriber['items'][index]['snippet']['title'], 10).toString(),
                              style: TextStyle(color:Colors.grey,fontSize: 12.0),)
                            ],
                          );
                        }),
                  ),
                ],
              ),
            )
          : Offstage();
    }

    return CustomScrollView(
      
      slivers: [
        appbar(context),
        SliverList(
          
          delegate: SliverChildBuilderDelegate(
            (bulidcontext, index) {
          if (videos != null) {
            if (index == 0) {
              return Column(
                children: [
                  sublist(),
                  Video_Container(
                      item: videos['items'][index],
                      isViewsCount: true,
                      onTapVideo: (item, channel) =>
                          showBottomSheetForVideo(item, channel, size, context))
                ],
              );
            } else {
              return Video_Container(
                  item: videos['items'][index],
                  isViewsCount: true,
                  onTapVideo: (item, channel) =>
                      showBottomSheetForVideo(item, channel, size, context));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        childCount: videos['items'].length
        ),
        )
      ],
    );
  }
}

/*
Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Container(
              child: ListView.builder(
                itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                        Text('name',style: TextStyle(color: Colors.black),)
                      ],
                    );
                  }),
            ),
      ),
      body: Container(
           
            
        child: Column(
          children: [
           
            
               Container(
                 height: 100,
              child: ListView.builder(
                itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            maxRadius: 28.0,
                            backgroundColor: Colors.red,
                          ),
                        ),
                        Text('name')
                      ],
                    );
                  }),
            ),
          
           
          
          ],
        ),
      ),
    );
*/
