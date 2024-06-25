import 'dart:convert';

import 'package:chat_app_white_label/main.dart';
import 'package:chat_app_white_label/src/components/app_bar_component.dart';
import 'package:chat_app_white_label/src/components/bottom_sheet_component.dart';
import 'package:chat_app_white_label/src/components/button_component.dart';
import 'package:chat_app_white_label/src/components/chat_tile_component.dart';
import 'package:chat_app_white_label/src/components/search_text_field_component.dart';
import 'package:chat_app_white_label/src/components/text_component.dart';
import 'package:chat_app_white_label/src/components/toast_component.dart';
import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/components/user_list_component.dart';
import 'package:chat_app_white_label/src/constants/app_constants.dart';
import 'package:chat_app_white_label/src/constants/asset_constants.dart';
import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/font_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/constants/shared_preference_constants.dart';
import 'package:chat_app_white_label/src/constants/size_box_constants.dart';
import 'package:chat_app_white_label/src/constants/string_constants.dart';
import 'package:chat_app_white_label/src/locals_views/user_profile_screen/cubit/user_screen_cubit.dart';
import 'package:chat_app_white_label/src/models/user_model.dart';
import 'package:chat_app_white_label/src/utils/chats_utils.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/shared_preferences_util.dart';
import 'package:chat_app_white_label/src/utils/theme_cubit/theme_cubit.dart';
import 'package:chat_app_white_label/src/wrappers/friend_list_response_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../../models/contact.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

String? userId;
UserModel? userModel;

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  // late AppSettingCubit appSettingCubit =
  //     BlocProvider.of<AppSettingCubit>(context);
  @override
  bool get wantKeepAlive => true;
  TextEditingController searchController = TextEditingController();
  void getUserId() async {
    final serializedUserModel = await getIt<SharedPreferencesUtil>()
        .getString(SharedPreferenceConstants.userModel);
    userModel = UserModel.fromJson(jsonDecode(serializedUserModel!));
    // userId = await getIt<SharedPreferencesUtil>()
    //     .getString(SharedPreferenceConstants.userIdValue);
    userId = userModel?.phoneNumber;
    setState(() {
    });
  }

  late final themeCubit = BlocProvider.of<ThemeCubit>(context);
  List<FriendListData> filteredContacts = [];
  final List<ContactModel> contacts = [
    ContactModel('Jesse Ebert', 'Graphic Designer', "", "00112233455"),
    ContactModel('Albert Ebert', 'Manager', "", "45612378123"),
    ContactModel('Json Ebert', 'Tester', "", "03323333333"),
    ContactModel('Mack', 'Intern', "", "03312233445"),
    ContactModel('Julia', 'Developer', "", "88552233644"),
    ContactModel('Rose', 'Human Resource', "", "55366114532"),
    ContactModel('Frank', 'xyz', "", "25651412344"),
    ContactModel('Taylor', 'Test', "", "5511772266"),
  ];
  List selectedContacts = [];
  late UserScreenCubit userScreenCubit =
      BlocProvider.of<UserScreenCubit>(context);

  @override
  void initState() {
    getUserId();
    userScreenCubit.fetchMyFriendListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor:themeCubit.backgroundColor),
    );

    print("user--- ${FirebaseUtils.user?.toJson()}");
    return BlocConsumer<UserScreenCubit, UserScreenState>(
      listener: (context, state) {
        if (state is FetchMyFriendListDataLoadingState) {
        } else if (state is FetchMyFriendListSuccessState) {
          userScreenCubit.initializeFriendListResponseWrapperData(
              state.friendListResponseWrapper);
          filteredContacts.clear();
          filteredContacts
              .addAll((userScreenCubit.friendListResponseWrapper.data ?? []));
          // totalCount = (userScreenCubit.friendListResponseWrapper.data?.length?? 0).toString();
        } else if (state is FetchMyFriendListFailureState) {
          // ToastComponent.showToast(state.toString(), context: context);
        }
      },
      builder: (context, state) {
        return UIScaffold(
          removeSafeAreaPadding: true,
          appBar: AppBarComponent(StringConstants.chat,

              titleFontSize: 30,
              showBackbutton: false,
              action: InkWell(
                onTap: () {
                  _showCreateChatBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorConstants.btnGradientColor,
                          ColorConstants.white
                        ],
                      )),
                  child: Icon(
                    Icons.add,
                    color: themeCubit.backgroundColor,
                  ),
                ),
              )),
          bgColor: themeCubit.backgroundColor,
          widget:
              // context.watch<AppSettingCubit>().isContactactsPermissionGranted
              //     ?

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
                    child: SearchTextField(
                      title: "Search",
                      hintText: "Search name ...",
                      onSearch: (text) {
                        setState(() {
                          // filteredContacts = dummyContactList
                          //     .where((contact) =>
                          // contact.name
                          //     .toLowerCase()
                          //     .contains(text.toLowerCase()) ||
                          //     contact.designation
                          //         .toLowerCase()
                          //         .contains(text.toLowerCase()))
                          //     .toList();
                        });
                      },
                      textEditingController: searchController,
                      filledColor: themeCubit.darkBackgroundColor,
                      iconColor: ColorConstants.lightGrey,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: ChatUtils.getAllChats(userId!),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text('Error fetching chats'));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: ColorConstants.greenMain,
                            ));
                          }
                          if ((snapshot.data?.docs ?? []).isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 80),
                              width: AppConstants.responsiveWidth(context,
                                  percentage: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetConstants.sad,
                                    height: 65,
                                    width: 65,
                                  ),
                                  SizedBoxConstants.sizedBoxTwentyH(),
                                  TextComponent(
                                    StringConstants.itsReallyQuiet,
                                    style: TextStyle(
                                        fontFamily: FontConstants.fontProtestStrike,
                                        color: themeCubit.textColor,
                                        fontSize: 30),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 30),
                                    child: TextComponent(
                                      StringConstants.startChatwithYourFriends,
                                      maxLines: 5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: themeCubit.textColor),
                                    ),
                                  ),
                                  SizedBoxConstants.sizedBoxTwentyH(),
                                  ButtonComponent(
                                      // isSmallBtn: true,
                                      btnWidth: AppConstants.responsiveWidth(context,
                                          percentage: 40),
                                      buttonText: StringConstants.startChat,
                                      bgcolor: themeCubit.primaryColor,
                                      textColor: themeCubit.backgroundColor,
                                      onPressed: () {})
                                ],
                              ),
                            );
                          }
                    
                          return ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                print(
                                    "snapshot.data!.docs[index].data() ${snapshot.data!.docs[index].data()}");
                                final ChatModel chat = ChatModel.fromJson(
                                    snapshot.data!.docs[index].data());
                                String? chatUserId;
                                print("chat--- ${chat.toJson()}");
                                if (chat.isGroup == false) {
                                  // get the id of other person of chat
                                  chatUserId = snapshot.data?.docs[index]
                                      .data()['users']
                                      .firstWhere(
                                          (id) => id != FirebaseUtils.user?.id);
                                  // Single user unread count
                                  chat.unreadCount =
                                      snapshot.data?.docs[index].data()[
                                          '${FirebaseUtils.user?.id}_unread_count'];
                                  print("chatUserId ${chatUserId}");
                                }
                                else {
                                  // condition to check if the 'read_count_group' is
                                  // not null if it is null it means group is new
                                  if (snapshot.data!.docs[index]
                                      .data()
                                      .containsKey('read_count_group')) {
                                    // check if it contain a key with userid
                                    // if it does not contain it means that user has not opened
                                    if (snapshot.data?.docs[index]
                                        .data()['read_count_group']
                                        .containsKey('${FirebaseUtils.user?.id}')) {
                                      chat.readCountGroup = snapshot.data?.docs[index]
                                              .data()['read_count_group']
                                          ['${FirebaseUtils.user?.id}'];
                                      chat.unreadCount = ((chat.messageCount ?? 0) -
                                              (chat.readCountGroup ?? 0))
                                          .toString();
                                    }
                                    else {
                                      chat.unreadCount = chat.messageCount.toString();
                                    }
                                  } else {
                                    // group currently have no message
                                    chat.unreadCount = '0';
                                  }
                                }
                                return FutureBuilder(
                                  future: chatUserId != null && chatUserId.isNotEmpty
                                      ? FirebaseUtils.getChatUser(chatUserId)
                                      : null,
                                  builder: (context, asyncSnapshot) {
                                    print("chatuserid ${chatUserId}");
                                    // var check = FirebaseUtils.getChatUser(chatUserId!);
                                    // print("check $check");
                                    // if user id is null so this is a group
                                    //  no need to read future snapshot user
                                    if (chatUserId != null) {
                                      if (asyncSnapshot.hasData) {
                                        print("chat-1 ${chat.toJson()}");
                                        UserModel chatUser = UserModel.fromJson(
                                            asyncSnapshot.data?.data() ?? {});
                                        // chatUser.firstName =
                                        //     FirebaseUtils.getNameFromLocalContact(
                                        //         chatUser.id ?? '', context);
                                        // chatUser.firstName =
                                        //     FirebaseUtils.getNameFromLocalContact(
                                        //         chatUser.id ?? '', context);
                                        return ChatTileComponent(
                                        chat: chat,
                                        chatUser: chatUser,
                                        );
                                            // Container();
                    
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      // return Container();
                                       return ChatTileComponent(
                                        chat: chat,
                                        chatUser: null,
                                      );
                                    }
                                  },
                                );
                              });
                        }),
                  ),
                ],
              ),
          // : const Center(
          //     child: CircularProgressIndicator(
          //     color: ColorConstants.greenMain,
          //   )),
          // floatingActionButton: SizedBox(
          //   width: 60,
          //   height: 60,
          //   child: FittedBox(
          //     child: FloatingActionButton(
          //       onPressed: () {
          //         NavigationUtil.push(context, RouteConstants.contactsScreen);
          //       },
          //       backgroundColor: ColorConstants.greenMain,
          //       child: const Icon(
          //         Icons.message,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }

  _showCreateChatBottomSheet() {
    BottomSheetComponent.showBottomSheet(context,
        takeFullHeightWhenPossible: false,
        isShowHeader: false,
        body: UserListComponent(
            headingName: StringConstants.createChat,
            dummyContactList: filteredContacts,
            selectedContacts: selectedContacts,
            subtitle: true,
            btnName: StringConstants.startChatting,
            onBtnTap: () {
              print("selectedContacts ${selectedContacts}");
              if (selectedContacts.isNotEmpty && selectedContacts.first!= null) {
                final replacedPhoneNumber = selectedContacts.first.replaceAll('+', '');
                FirebaseUtils.getChatUser(replacedPhoneNumber).then((value) {
                  print("value ${value.data()}");
                  if (value.data()!= null) {
                    print("value ${value.data()}");
                    UserModel chatUser = UserModel.fromJson(value.data());
                    print("chat user ${chatUser}");
                    selectedContacts.clear();

                    NavigationUtil.pop(context);
                    NavigationUtil.push(context, RouteConstants.chatRoomScreen, args: [chatUser, '0']);
                  }
                })
                // ;
                    .catchError((error) {
                  // Handle error case here
                  print("Error fetching chat user: $error");
                  ToastComponent.showToast(error.toString(), context: context);
                });
              } else {

                // Handle the case where selectedContacts is empty or null
                print("No valid selected contact found.");
              }
            }));
  }
}
