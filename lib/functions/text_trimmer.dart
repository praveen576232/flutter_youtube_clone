import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube/dummydata/search.dart';
import 'package:youtube/dummydata/subscriber.dart';
import 'package:youtube/dummydata/videoinfo.dart';
import 'package:youtube/youtube_api/api.dart';
import 'package:youtube/youtube_api/request.dart';

stringtrimmer(str, n) {
  if (str.length > n) {
    return str.toString().substring(0, n) + "...";
  }
  return str;
}

Future suggestedVideo(url) async {
  http.Response response = await http.get(url);
  if (response != null) {
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    return null;
  }


}

Future videoStatices(id) async {
  final video_statistics =
      'https://www.googleapis.com/youtube/v3/videos?part=statistics&id=${id}&key=${API_KEY}';
  http.Response response = await http.get(video_statistics);
  if (response != null) {
    return json.decode(response.body);
  } else {
    return null;
  }
 
}

get_channel_logo(String id) async {
  var get_channel_logo =
      'https://www.googleapis.com/youtube/v3/channels?part=snippet%2Cstatistics&id=${id}&key=${API_KEY}';
  print(get_channel_logo);
  http.Response res = await http.get(get_channel_logo);
  if (res != null) {
    // setState(() {
    var channel = jsonDecode(res.body);
    return channel;
    // });
  }
}

Future listOfSubscriber() async {
//  http.Response res = await http.get(subscription);
//   if (res != null) {

//     var sub = jsonDecode(res.body);
//     return sub;

//   }

  return sub;
}
