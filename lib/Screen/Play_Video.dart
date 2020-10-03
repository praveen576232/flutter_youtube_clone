import 'package:flutter/material.dart';
import 'package:youtube/Screen/Video_Container/Video_Container.dart';
import 'package:youtube/animations/Animation_expand.dart';
import 'package:youtube/functions/number_formate.dart';
import 'package:youtube/functions/text_trimmer.dart';
import 'package:youtube/functions/time_ago.dart';
import 'package:youtube/youtube_api/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  var item;
  var channel;
  var videostatics;
  bool fromHome;
  PlayVideo(
      {@required this.item,
      this.channel,
      @required this.fromHome,
      this.videostatics});
  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  YoutubePlayerController _controller;
  var url = '';
  String playVideoId;
  bool discription_open = false;
  var click_video;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.videostatics != null) {
      click_video = widget.videostatics;
    }

    playVideoId =
        widget.fromHome ? widget.item['id'] : widget.item['id']['videoId'];
    _controller = YoutubePlayerController(
        initialVideoId: playVideoId, flags: YoutubePlayerFlags(autoPlay: true));

    var endpoint =
        widget.item['snippet']['tags'] != null && widget.item['snippet']['tags']?.length >0 ? widget.item['snippet']['tags'][0] : 'flutter';

    url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&chart=mostPopular&maxResults=30&regionCode=IN&order=date&q=${endpoint}&key=${API_KEY}';
  }

  Widget icon_text_button(Icon icons, String text) {
    return Column(
      children: [
        IconButton(icon: icons, padding: EdgeInsets.all(0.0), onPressed: null),
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  Widget change_text_check_hashtag(str) {
    var world = str.toString().split(" ");

    return RichText(
        text: TextSpan(
            children: world
                .map((e) => e.startsWith("#") ||
                        e.startsWith('http://') ||
                        e.startsWith('https://')
                    ? TextSpan(
                        text: "${e} ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 15))
                    : TextSpan(
                        text: "${e} ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15)))
                .toList()));
  }

  Widget ChannelInfo(Size size) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 15, left: 5),
            child: Column(
              children: [
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: size.width * 0.8,
                            child: change_text_check_hashtag(
                              widget.item['snippet']['title'],
                            )),
                        IconButton(
                            icon: Icon(
                              discription_open
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 35,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                discription_open = !discription_open;
                              });
                            })
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        discription_open = !discription_open;
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: widget.fromHome
                              ? Text(
                                  widget.item['statistics']['viewCount'] != null
                                      ? discription_open
                                          ? widget.item['statistics']
                                                  ['viewCount'] +
                                              ' views'
                                          : number_formate(
                                                  widget.item['statistics']
                                                      ['viewCount']) +
                                              ' views'
                                      : '',
                                  style: TextStyle(color: Colors.grey),
                                )
                              : FutureBuilder(
                                future: videoStatices(
                                                        widget.item['id']['videoId']),
                                builder: (context, snapshot) {
                                  click_video = snapshot.data;
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                    return Text(
                                      snapshot.data['items'][0]['statistics']
                                                  ['viewCount'] !=
                                              null
                                          ? "${number_formate(snapshot.data['items'][0]['statistics']['viewCount'])} views"
                                          : '',
                                      style: TextStyle(color: Colors.grey),
                                    );
                                  } else {
                                    return Text('');
                                  }
                                })),
                      Text(
                        formatetime(widget.item['snippet']['publishedAt']),
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon_text_button(
                Icon(Icons.thumb_up),
                widget.fromHome
                    ? number_formate(widget.item['statistics']['likeCount'])
                    :click_video!=null ? number_formate(
                        click_video['items'][0]['statistics']['likeCount']):''),
            icon_text_button(
                Icon(Icons.thumb_down),
                widget.fromHome
                    ? number_formate(widget.item['statistics']['dislikeCount'])
                    : click_video!=null ? number_formate(
                       click_video['items'][0]['statistics']['dislikeCount']):''),
            icon_text_button(Icon(Icons.share), "Share"),
            icon_text_button(Icon(Icons.file_download), "Download"),
            icon_text_button(Icon(Icons.add_to_photos), "Save")
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: size.height * 0.09,
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey[200], width: 2),
                bottom: BorderSide(color: Colors.grey[200], width: 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 5),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(widget.channel['items'][0]
                      ['snippet']['thumbnails']['default']['url']),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.channel['items'][0]['snippet']['title']
                                .toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              number_formate(widget.channel['items'][0]
                                      ['statistics']['subscriberCount']) +
                                  ' subscribers'.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text("SUBCRIBE",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17)),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'JOIN',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.notifications_active), onPressed: null)
            ],
          ),
        ),
        Animated_expand(
          is_expand: discription_open,
          child: Container(
              padding: EdgeInsets.only(top: 8.0, left: 15.0),
              child: change_text_check_hashtag(
                  widget.item['snippet']['description'])),
        ),
        Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Up next",
                    style: TextStyle(color: Colors.grey[400], fontSize: 13)),
              ),
              Container(
                child: Row(
                  children: [
                    Text("Autoplay",
                        style: TextStyle(
                            color: Colors.blueGrey[400], fontSize: 13)),
                    Switch(
                        activeColor: Colors.blue,
                        value: true,
                        onChanged: (val) => {})
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  child: YoutubePlayer(
                      liveUIColor: Colors.red,
                      progressColors: ProgressBarColors(
                          backgroundColor: Colors.white,
                          bufferedColor: Colors.grey,
                          playedColor: Colors.red,
                          handleColor: Colors.red),
                      controller: _controller),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      width: size.width,
                      child: FutureBuilder(
                          future: suggestedVideo(url),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: snapshot.data != null
                                      ? ListView.builder(
                                          itemBuilder: (context, index) {
                                            return Column(children: [
                                              index == 0
                                                  ? ChannelInfo(size)
                                                  : Offstage(),
                                              Video_Container(
                                                item: snapshot.data['items']
                                                    [index],
                                                isViewsCount: false,
                                                onTapVideo: (item, channel) {
                                                  setState(() {
                                                    _controller.load(
                                                        item['id']['videoId']);
                                                    widget.channel = channel;
                                                    widget.item = item;
                                                        widget.fromHome = false;
                                                  });
                                                  // videoStatices(
                                                  //         item['id']['videoId'])
                                                  //     .then((value) {
                                                  //   if (value != null) {
                                                  //     setState(() {
                                                  //       click_video = value;
                                                  //     });
                                                  //   }
                                                  // });
                                                },
                                              ),
                                            ]);
                                          },
                                          itemCount:
                                              snapshot.data['items'].length,
                                        )
                                      : CircularProgressIndicator());
                            } else {
                              return Column(
                                children: [
                                  ChannelInfo(size),
                                  CircularProgressIndicator(),
                                ],
                              );
                            }
                          })),
                )
              ],
            )),
      ),
    );
  }
}
