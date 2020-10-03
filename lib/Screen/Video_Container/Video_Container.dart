import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube/Screen/Play_Video.dart';
import 'package:youtube/functions/number_formate.dart';
import 'package:youtube/functions/text_trimmer.dart';
import 'package:http/http.dart' as http;
import 'package:youtube/functions/time_ago.dart';
import 'package:youtube/youtube_api/api.dart';

class Video_Container extends StatefulWidget {
  var item;
  bool isViewsCount;
  Function onTapVideo;
  Video_Container({@required this.item, this.isViewsCount, this.onTapVideo});
  @override
  _Video_ContainerState createState() => _Video_ContainerState();
}

class _Video_ContainerState extends State<Video_Container> {
  var channel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              child: Image.network(
                widget.item["snippet"]["thumbnails"]['high']['url'],
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                height: size.height * 0.1,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        child: FutureBuilder(
                            future: get_channel_logo(
                                widget.item['snippet']['channelId']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                channel = snapshot.data;
                                return CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      snapshot.data['items'][0]['snippet']
                                          ['thumbnails']['default']['url']),
                                );
                              } else {
                                return Offstage();
                              }
                            })),
                    Container(
                      child: Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stringtrimmer(
                                  widget.item["snippet"]['title'], 50),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                              overflow: TextOverflow.fade,
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.item["snippet"]['channelTitle'] + '  ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  widget.isViewsCount
                                      ? number_formate(widget.item['statistics']
                                              ['viewCount']) +
                                          ' views  '
                                      : '',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  formatetime(
                                      widget.item["snippet"]['publishedAt']),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.fade,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                          icon: Icon(Icons.more_vert), onPressed: null),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => widget.onTapVideo(widget.item, channel),
    );
  }
}
