import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/contact_tile_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/models/contact.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_text_field_component.dart';
import 'text_component.dart';

class UserListComponent extends StatefulWidget {
  final String headingName;
  final String btnName;
  List? selectedContacts = [];
  final Function()? onBtnTap;
  final bool subtitle;
  List<ContactModel> dummyContactList;

  UserListComponent({super.key, required this.headingName,  this.subtitle=false,required this.dummyContactList, required this.btnName, this.onBtnTap,this.selectedContacts});

  @override
  State<UserListComponent> createState() => _UserListComponentState();
}

class _UserListComponentState extends State<UserListComponent> {
  @override
  Widget build(BuildContext context) {
    late final themeCubit = BlocProvider.of<ThemeCubit>(context);
    TextEditingController searchController = TextEditingController();

    return   Container(
      color: ColorConstants.darkBackgrounddColor,
      height: AppConstants.responsiveHeight(context, percentage: 90),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          widget.headingName,
                          style: TextStyle(
                              color: themeCubit.primaryColor,
                              fontSize: 20,
                              fontFamily: FontConstants.fontProtestStrike),
                        ),
                        InkWell(
                            onTap: () => NavigationUtil.pop(context),
                            child: const Icon(Icons.close,color: ColorConstants.white,))
                      ],
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    if(widget.subtitle)
                    TextComponent(
                      StringConstants.startDirectChat,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontConstants.fontNunitoSans,
                          color: themeCubit.textColor),
                    ),
                    SizedBoxConstants.sizedBoxTenH(),
                    SearchTextField(
                      iconColor: ColorConstants.lightGrey.withOpacity(0.6),
                      title: "Search",
                      hintText: "Search for people",
                      onSearch: (text) {
                        // widget.viewModel.onSearchStories(text);
                      },
                      textEditingController: searchController,
                      filledColor:
                      ColorConstants.blackLight.withOpacity(0.6),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.dummyContactList.length,
                    itemBuilder: (context, index) {
                      bool isLast = index == widget.dummyContactList.length - 1;
                      return ContactTileComponent(
                        showDivider: (!isLast),
                        title: widget.dummyContactList[index].name,
                        subtitle: widget.dummyContactList[index].title,
                        isSelected: (widget.selectedContacts ?? []).contains(index),
                        onTap: () {
                          if ((widget.selectedContacts ?? []).contains(index)) {
                           ( widget.selectedContacts ?? []).remove(index);
                          } else {
                            (widget.selectedContacts ?? []).add(index);
                          }
                          setState(() {});
                          LoggerUtil.logs(widget.selectedContacts ?? []);
                        },
                      );
                    }),
              ),
              SizedBoxConstants.sizedBoxThirtyH(),
              Container(
                margin:
                const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                width: double.infinity,
                height: 45,
                child: ButtonComponent(
                    textColor: themeCubit.darkBackgroundColor,
                    buttonText:widget.btnName,
                    bgcolor: themeCubit.primaryColor,
                    onPressed: widget.onBtnTap),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(child: Container()),

            ],
          )
        ],
      ),
    );
  }
}
