import 'package:flutter/material.dart';
import 'package:youtube/Screen/AppBar.dart';
import 'package:youtube/dummydata/video.dart';
import 'package:youtube/functions/text_trimmer.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var history;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    history = video;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(slivers: [
      appbar(context),
      SliverList(
          delegate: SliverChildListDelegate(
            
            [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: Text('Recent'),
        ),
        Container(
          height: size.height * 0.2,
          width: size.width,
          child: history != null
              ? ListView.builder(
              
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.only(left: 20),
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(history['items'][index]['snippet']
                                ['thumbnails']['high']['url']),
                            Text(
                              stringtrimmer(
                                      history['items'][index]['snippet']
                                          ['title'],
                                      30)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              stringtrimmer(
                                      history['items'][index]['snippet']
                                          ['channelTitle'],
                                      30)
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            )
                          ],
                        ));
                  })
              : Text('no history found'),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.grey,
              ),
              title: Text('History'),
            ),
            ListTile(
              leading: Icon(
                Icons.file_download,
                color: Colors.grey,
              ),
              title: Text('Downloads'),
            ),
            ListTile(
              leading: Icon(
                Icons.video_library,
                color: Colors.grey,
              ),
              title: Text('Your videos'),
            ),
            ListTile(
              leading: Icon(
                Icons.timer,
                color: Colors.grey,
              ),
              title: Text('Watch later'),
            ),
              Container(
          height: 2,
          color: Colors.grey[300],
        ),
       Padding(
         padding: const EdgeInsets.only(left:20.0,top:8.0),
         child: Text('Playlists'),
       ),
        ListTile(
              leading: Icon(
                Icons.add,
                color: Colors.blue,
                size: 40.0,
              ),
              title: Text('New Playlist'),
            ),
            ListTile(
              leading: Icon(
                Icons.thumb_up,
                color: Colors.grey,
              ),
              title: Text('Liked videos'),
              subtitle: Text('380 videos'),
            ),
           
      ],addRepaintBoundaries: false))
    ]);
  }
}
