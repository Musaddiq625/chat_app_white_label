import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import 'icon_component.dart';

class CreateEventTileComponent extends StatelessWidget {
  final icon;
  final iconText;
  final subText;
  final Function()? onTap;
  const CreateEventTileComponent({super.key, this.icon, this.iconText, this.subText, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: ColorConstants.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconComponent(
                    iconData: icon,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    circleSize: 15,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    iconText,
                    style: TextStyle(fontSize: 15),
                  ),
                  Spacer(),
                  Text(
                    subText,
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  IconComponent(
                    iconData: Icons.arrow_forward_ios,
                    borderColor: ColorConstants.transparent,
                    backgroundColor: ColorConstants.transparent,
                    circleSize: 15,
                    iconColor: ColorConstants.lightGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}



