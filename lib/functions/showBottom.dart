import 'package:flutter/material.dart';
import 'package:youtube/Screen/Play_Video.dart';

void showBottomSheetForVideo(var item, var channel, Size size,BuildContext context) {
    print("home page is clicked on " + item.toString());
    print("home page channel is clicked on " + channel.toString());
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              height: size.height,
              width: size.width,
              child: PlayVideo(
                   item:item,
                   channel:channel,
                   videostatics:null,
                   fromHome:true
               ),
            ));
  }