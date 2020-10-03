import 'package:flutter/material.dart';
import 'package:youtube/Screen/Play_Video.dart';
import 'package:youtube/dummydata/search.dart';
import 'package:youtube/functions/number_formate.dart';
import 'package:youtube/functions/text_trimmer.dart';
import 'package:youtube/functions/time_ago.dart';
import 'package:youtube/youtube_api/api.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchResult;
  bool searching = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  void showBottomSheet(var video, var channel, var videoStatices, Size size) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              height: size.height,
              width: size.width,
              child:PlayVideo(
                   item:video,
                   channel:channel,
                   videostatics:videoStatices,
                   fromHome:false
               ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Container(
            height: 35.0,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                textAlign: TextAlign.start,
                cursorWidth: 1.0,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search YouTube',
                ),
                onSubmitted: (text) {
                 if(text !=null){
                    setState(() {
                    searching = true;
                  });
                  suggestedVideo(serachQuery(text)).then((value) {
                    setState(() {
                      searching = false;
                      searchResult = value;
                    });
                  });
                 }
                },
              ),
            ),
          ),
          actions: [
            CircleAvatar(
                backgroundColor: Colors.grey[100],
                child: IconButton(
                    icon: Icon(Icons.mic, color: Colors.grey[700]),
                    onPressed: () {})),
          ],
        ),
        body: searchResult != null
            ? Container(
                child: ListView.builder(
                    itemCount: searchResult['items'].length,
                    itemBuilder: (context, index) {
                      var videostatices;
                     
                      return InkWell(
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              Image.network(
                                searchResult['items'][index]['snippet']
                                    ['thumbnails']['high']['url'],
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                width: size.width - 200,
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(stringtrimmer(
                                            searchResult['items'][index]
                                                ['snippet']['title'],
                                            100)
                                        .toString()),
                                    Text(
                                      stringtrimmer(
                                              searchResult['items'][index]
                                                  ['snippet']['channelTitle'],
                                              100)
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13.0),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          formatetime(searchResult['items']
                                                          [index]['snippet']
                                                      ['publishTime'])
                                                  .toString() +
                                              ' ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.0),
                                        ),
                                        FutureBuilder(
                                            future: videoStatices(
                                                searchResult['items'][index]
                                                    ['id']['videoId']),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                      ConnectionState.done &&
                                                  snapshot.hasData) {
                                                videostatices = snapshot.data;
                                                return Text(
                                                  number_formate(snapshot
                                                                  .data['items']
                                                              [0]['statistics']
                                                          ['viewCount']) +
                                                      ' views',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13.0),
                                                );
                                              } else {
                                                return Text('');
                                              }
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                         
                             
                          get_channel_logo(searchResult['items'][index]
                                  ['snippet']['channelId'])
                              .then((channel) {
                            showBottomSheet(searchResult['items'][index],
                                channel, videostatices, size);
                          });
                        },
                      );
                    }),
              )
            : searching
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container());
  }
}

serachQuery(String query) {
  var url =
      'https://www.googleapis.com/youtube/v3/search?part=snippet&chart=mostPopular&maxResults=30&regionCode=IN&order=date&q=${query}&key=${API_KEY}';
  return url;
}
