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
          Image.asset(
            // AssetConstants.group,
            widget.image,
            width: 150,
            height: 150,
          ),
           Text(
            widget.heading,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.body?? "",
            style: TextStyle( fontSize: 14),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
