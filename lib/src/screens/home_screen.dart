import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/screens/app_setting_cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/screens/calls_screen.dart';
import 'package:chat_app_white_label/src/screens/chat_screen/chat_screen.dart';
import 'package:chat_app_white_label/src/screens/status_screen.dart';
import 'package:chat_app_white_label/src/utils/firebase_utils.dart';
import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:chat_app_white_label/src/utils/permission_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget with WidgetsBindingObserver {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AppSettingCubit appSettingCubit =
      BlocProvider.of<AppSettingCubit>(context);
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await appSettingCubit.initGetLocalContacts(context);
      PermissionUtils.requestCameraAndMicPermission();
    });
    SystemChannels.lifecycle.setMessageHandler((message) async {
      LoggerUtil.logs('message $message');
      if (FirebaseUtils.user != null) {
        if (message.toString().contains('resume')) {
          FirebaseUtils.updateActiveStatus(true);
          if (appSettingCubit.isContactactsPermissionGranted == false) {
            await appSettingCubit.initGetLocalContacts(context);
          }
        }
        if (message.toString().contains('pause')) {
          FirebaseUtils.updateActiveStatus(false);
        }
        if (message.toString().contains('detached')) {
          FirebaseUtils.updateActiveStatus(false);
        }
      }
      return Future.value(message);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.greenMain,
          title: Text(
            FirebaseUtils.user?.name ?? "",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseUtils.logOut(context);
              },
              icon: const Icon(
                Icons.logout,
                size: 28,
              ),
              color: ColorConstants.white,
            ),
            IconButton(
              onPressed: () {
                NavigationUtil.push(context, RouteConstants.editProfileScreen,
                    args: true);
              },
              icon: const Icon(
                Icons.edit,
                size: 28,
              ),
              color: ColorConstants.white,
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            controller: tabController,
            tabs: const [
              Tab(text: "CHATS"),
              Tab(text: "STATUS"),
              Tab(text: "CALLS"),
            ],
          )),
      body: TabBarView(
        controller: tabController,
        children: const [
          ChatScreen(),
          StatusScreen(),
          CallScreen(),
        ],
      ),
    );
  }
}
