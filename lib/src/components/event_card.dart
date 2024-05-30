import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../constants/color_constants.dart';
import '../constants/font_styles.dart';
import '../constants/size_box_constants.dart';
import '../constants/string_constants.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int? totalCount;
  final List<String> images;
  final double radius2;
  final String? startTime;
  final String? endTime;
  final bool viewTicket;

  EventCard({
    required this.imageUrl,
    required this.title,
    required this.images,
    required this.radius2,
    this.totalCount,
    this.startTime,
    this.endTime,
    this.viewTicket = false,
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
              if (viewTicket)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          // color: themeCubit.darkBackgroundColor,
                        ),
                        child: TextComponent(StringConstants.viewTicket,
                            textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if ((totalCount ?? 0) > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: radius2 * images.length.toDouble(),
                              height: radius2,
                              child: Stack(
                                children: [
                                  for (int i = 0; i < images.length; i++)
                                    Positioned(
                                      left: i * radius2 / 1.5,
                                      child: ClipOval(
                                        child: ImageComponent(
                                          imgUrl: images[i],
                                          width: radius2,
                                          height: radius2,
                                          imgProviderCallback:
                                              (ImageProvider<Object>
                                                  imgProvider) {},
                                        ),
                                        // Image(
                                        //   image: images[i],
                                        //   width: radius2,
                                        //   height: radius2,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            TextComponent(
                              "+${totalCount} ${StringConstants.joined}",
                              style: FontStylesConstants.style12(
                                  color: ColorConstants.white),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextComponent(
                        title,
                        style: FontStylesConstants.style20(
                          color: ColorConstants.white,
                        ),
                        maxLines: 6,
                      ),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child:
                      // TextComponent(
                      //   "17 Feb . 11AM - 2PM ",
                      //   style: FontStylesConstants.style13(
                      //       color: ColorConstants.white),
                      // ),
                      TextComponent(
                        "",
                        listOfText: [
                          DateFormat('d MMM \'at\' hh a').format(DateTime.tryParse(startTime?? "")?? DateTime.now()),
                          //    DateFormat('d MMM \'at\' hh a').format(DateTime.parse(eventCubit.eventModelList[index].venues?.first.endDatetime ?? "")),
                          "-",
                          DateFormat('d MMM \'at\' hh a')
                              .format(DateTime.tryParse(endTime?? "")?? DateTime.now()),                        ],
                        listOfTextStyle: [
                          FontStylesConstants.style13(color: ColorConstants.white),
                          FontStylesConstants.style13(color: ColorConstants.white),
                          FontStylesConstants.style13(color: ColorConstants.white),
                        ],
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
