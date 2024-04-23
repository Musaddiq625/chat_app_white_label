import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:flutter/cupertino.dart';

import '../constants/color_constants.dart';
import '../constants/font_styles.dart';
import '../constants/size_box_constants.dart';
import '../constants/string_constants.dart';

class GroupCard extends StatelessWidget {
  final String imageUrl;
  final List<String> images;
  final String membersCount;
  final String name;

  GroupCard({
    required this.imageUrl,
    required this.images,
    required this.name ,
    this.membersCount ="0",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        width: 186,
        height: 308,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextComponent(
                        "Property networking event",
                        style:
                            FontStylesConstants.style20(color: ColorConstants.white),
                        maxLines: 6,
                      ),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextComponent(
                        "${membersCount} Members",
                        style:
                            FontStylesConstants.style13(color: ColorConstants.white),
                      ),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
