import 'package:chat_app_white_label/src/components/profile_image_component.dart';
import 'package:chat_app_white_label/src/components/user_tile_component.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';

import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/create_group_chat/select_contacts_screen.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewGroupProfileScreen extends StatefulWidget {
  final ChatModel group;
  const ViewGroupProfileScreen({super.key, required this.group});

  @override
  State<ViewGroupProfileScreen> createState() => _ViewGroupProfileScreenState();
}

class _ViewGroupProfileScreenState extends State<ViewGroupProfileScreen> {
  late AppSettingCubit appSettingCubit =
      BlocProvider.of<AppSettingCubit>(context);
  late final ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
              backgroundColor: themeCubit.darkBackgroundColor,//ColorConstants.greenMain,
              title: Text(widget.group.groupData?.grougName ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              leading: IconButton(
                onPressed: () => NavigationUtil.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
                color: ColorConstants.white,
              )),
          //body
          backgroundColor: themeCubit.backgroundColor,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  //user profile picture
                  ProfileImageComponent(
                    url: widget.group.groupData?.groupImage,
                    size: 150,
                    isGroup: true,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Group Name',
                    style: TextStyle(
                        color: ColorConstants.white,//ColorConstants.greenMain,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(widget.group.groupData?.grougName ?? '',
                        style: const TextStyle(
                            color: ColorConstants.white, fontSize: 16)),
                  ),
                  const SizedBox(height: 30),
                  //user about
                  const Text(
                    'About',
                    style: TextStyle(
                        color: ColorConstants.white,//ColorConstants.greenMain,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Text(widget.group.groupData?.groupAbout ?? '',
                      style:
                          const TextStyle(color: ColorConstants.white, fontSize: 15)),
                  const SizedBox(height: 30),
                  const Text(
                    'Members',
                    style: TextStyle(
                        color: ColorConstants.white,//ColorConstants.greenMain,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.primaryColor)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: (widget.group.users ?? []).length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: FirebaseUtils.getChatUser(
                                  (widget.group.users
                                      ?? [])[index]),
                              builder: (context, asyncSnapshot) {
                                UserModel firebaseContactUser = UserModel.fromJson(asyncSnapshot.data?.data() ?? {});
                                return UserTileComponent(
                                    localName:
                                        FirebaseUtils.getNameFromLocalContact(
                                            (widget.group.users ?? [])[index],
                                            context),
                                    chatUser: firebaseContactUser,
                                    showAdminIcon: widget.group.users?[index] ==
                                        widget.group.groupData?.adminId,
                                      // onRemoveTap:
                                    // widget.group.groupData?.adminId ==
                                    //         FirebaseUtils.user?.id
                                    //     ? () {
                                    //         ChatUtils.removeMemberFromGroupChat(
                                    //             widget.group.groupData?.id ??
                                    //                 '',
                                    //             widget.group.users?[index] ??
                                    //                 '');
                                    //         widget.group.users?.remove(
                                    //             widget.group.users?[index]);
                                    //         setState(() {});
                                    //       }
                                    //     : null
                                );
                              });
                        }),
                  ),
                  const SizedBox(height: 20),
                  // if (widget.group.groupData?.adminId == FirebaseUtils.user?.id)
                  //   InkWell(
                  //     onTap: () => NavigationUtil.push(
                  //         context, RouteConstants.selectContactsScreen,
                  //         args: SelectContactsScreenArg(
                  //             contactsList: appSettingCubit.contactToDisplay,
                  //             selectedContacts: widget.group.users,
                  //             groupChatId: widget.group.id)),
                  //     child: const Text(
                  //       'Add More Members',
                  //       style: TextStyle(
                  //           color: ColorConstants.greenMain,
                  //           fontWeight: FontWeight.w500,
                  //           decoration: TextDecoration.underline,
                  //           fontSize: 15),
                  //     ),
                  //   ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          )),
    );
  }
}
