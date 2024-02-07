import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: ColorConstants.green,
              child: const Icon(
                Icons.add_call,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = snapshot.data!.docs[index];
                    return ListTile(
                      title: const Text("xyx"),
                      subtitle: const Text("Hello"),
                      // title: Text(chat['chatName']),
                      // subtitle: Text(chat['lastMessage']),
                      onTap: () {},
                    );
                  },
                );

                //  ListView.separated(
                //   itemBuilder: (context, index) => CallTileComponent(
                //     name: callList.calls.values.elementAt(index).elementAt(0) as String,
                //     image: callList.calls.values.elementAt(index).elementAt(1) as String,
                //     videocall: callList.calls.values.elementAt(index).elementAt(2) as int,
                //     isMissed: callList.calls.values.elementAt(index).elementAt(3) as bool,
                //     inComing: callList.calls.values.elementAt(index).elementAt(4) as bool,
                //     time: callList.calls.values.elementAt(index).elementAt(5) as String,
                //   ),
                //   separatorBuilder: (context, index) =>
                //       callList.calls.values.elementAt(index).elementAt(6) as bool
                //           ? const SizedBox(
                //               height: 10,
                //             )
                //           : const Seperator(),
                //   itemCount: callList.calls.length,
                // ),
              }
            }));
  }
}
