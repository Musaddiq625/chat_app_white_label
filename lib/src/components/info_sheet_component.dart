import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:flutter/cupertino.dart';

import '../constants/image_constants.dart';

class InfoSheetComponent extends StatefulWidget {
  final heading;
  final body;
  final image;

  const InfoSheetComponent({super.key, this.heading, this.body, this.image});

  @override
  State<InfoSheetComponent> createState() => _InfoSheetComponentState();
}

class _InfoSheetComponentState extends State<InfoSheetComponent> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
            width: double.infinity,
          ),
          if(widget.image != null)
          Image.asset(
            // AssetConstants.group,
            widget.image,
            width: 150,
            height: 150,
          ),
           Container(
             width:300,
             child: Text(
              widget.heading,
              style: TextStyle(fontSize: 20,fontFamily: FontConstants.fontProtestStrike,),
               textAlign: TextAlign.center,
                       ),
           ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            child: Text(
              widget.body?? "",
              style: TextStyle( fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
