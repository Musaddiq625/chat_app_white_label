import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_white_label/src/components/status_tiles_component.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.primary,
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 28,
            ),
          ),
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.primary,
          leading: Container(
            child: Icon(
              Icons.camera_alt_rounded,
              color: Colors.white.withOpacity(0.5),
              size: 28,
            ),
          ),
          actions: [
            Container(
              width: 80,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtil.push(context, RouteConstants.chatScreen);
                      },
                      child: Text(
                        'CHATS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 115,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'STATUS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 115,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () {
                        NavigationUtil.push(context, RouteConstants.callScreen);
                      },
                      child: Text(
                        'CALLS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/woman.png',
                        ),
                      ),
                      Positioned(
                          left: 30,
                          top: 30,
                          child: CircleAvatar(
                            backgroundColor: ColorConstants.green,
                            radius: 10,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ))
                    ],
                  ),
                  title: Text(
                    'My Status',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Tap to add status update',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Recent Updates',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const StatusTileComponent(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blueGrey.shade50,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 3,
                            ),
                          ]),
                      child: const ImageIcon(
                        AssetImage(
                          'assets/images/pencil.png',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 58,
                        width: 58,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstants.green,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 3),
                                blurRadius: 3,
                              ),
                            ]),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 26,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
