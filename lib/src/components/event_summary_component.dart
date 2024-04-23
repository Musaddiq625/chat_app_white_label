import 'package:chat_app_white_label/src/components/image_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/divier_constants.dart';
import 'package:chat_app_white_label/src/constants/font_styles.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventSummary extends StatelessWidget {
  final String eventTitle;
  final String? price;
  final int ticketsSold;
  final int remainingTickets;
  final bool eventActive;
  final bool currenStats;
  final List<String> imagesUserInEvent;

  const EventSummary({
    Key? key,
    required this.eventTitle,
    this.price,
    required this.ticketsSold,
    required this.remainingTickets,
    required this.eventActive,
    this.currenStats= false,
    required this.imagesUserInEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = 30.0; // Example radius, adjust as needed
    final images = imagesUserInEvent; // Use the images passed as a parameter

    late final themeCubit = BlocProvider.of<ThemeCubit>(context);

    return Container(
      width:AppConstants.responsiveWidth(context,percentage: currenStats ? 100 : 80),
          //MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
      decoration: BoxDecoration(
        color: ColorConstants.darkBackgrounddColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(currenStats == true)
                  TextComponent(
                    eventTitle,
                    style:
                    FontStylesConstants.style20(color: ColorConstants.primaryColor),
                  ),
                if(currenStats == false)
                TextComponent(
                  eventTitle,
                  style:
                      FontStylesConstants.style16(fontWeight: FontWeight.bold),
                ),
                if(price != null)
                TextComponent(
                  price!,
                  style: FontStylesConstants.style16(),
                ),
              ],
            ),
          ),
        currenStats ?
        SizedBoxConstants.sizedBoxTwentyH():
          DividerCosntants.divider1,

          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, left: 15, right: 15, bottom: 18),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: radius * images.length.toDouble(),
                        height: radius,
                        child: Stack(
                          children: [
                            for (int i = 0; i < images.length; i++)
                              Positioned(
                                left: i * radius / 1.5,
                                child: ClipOval(
                                  child:
                                  ImageComponent(
                                    imgUrl: images[i], width: radius,height: radius,imgProviderCallback: (ImageProvider<Object> imgProvider) {  },
                                  ),
                                  // Image(
                                  //   image: images[i],
                                  //   width: radius,
                                  //   height: radius,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTenH(),
                      TextComponent(
                        "$ticketsSold Tickets Sold",
                        style: FontStylesConstants.style16(
                            color: ColorConstants.white),
                      ),
                      SizedBoxConstants.sizedBoxForthyH(),
                      SizedBox(
                        width: 150,
                        height: 10,
                        child: LinearProgressIndicator(
                          value: ticketsSold / (ticketsSold + remainingTickets),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          backgroundColor:
                              ColorConstants.lightGray.withOpacity(0.3),
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                      SizedBoxConstants.sizedBoxSixH(),
                      TextComponent(
                        "$remainingTickets Remaining",
                        style: FontStylesConstants.style16(
                            color: ColorConstants.white),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: TextComponent(
                          "SAR 600",
                          style: FontStylesConstants.style22(
                              color: ColorConstants.primaryColor),
                        ),
                      ),
                      SizedBoxConstants.sizedBoxSixH(),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: TextComponent(
                          StringConstants.earned,
                          style: FontStylesConstants.style16(
                              color: ColorConstants.white),
                        ),
                      ),
                      SizedBoxConstants.sizedBoxTwentyH(),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: eventActive,
                          activeColor: ColorConstants.white,
                          activeTrackColor: themeCubit.primaryColor,
                          onChanged: (bool value) {
                            // Handle switch change
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: TextComponent(
                          StringConstants.visible,
                          style: FontStylesConstants.style16(
                              color: ColorConstants.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
