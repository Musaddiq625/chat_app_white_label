import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_white_label/src/models/chat_model.dart';
import 'package:chat_app_white_label/src/models/usert_model.dart';
import 'package:chat_app_white_label/src/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final UserModel? user;
  final GroupData? group;

  const ViewProfileScreen({super.key, this.user, this.group});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
              title: Text(widget.user != null
                  ? widget.user?.name ?? ''
                  : widget.group?.grougName ?? '')),
          floatingActionButton: //user about
              widget.user != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Last Active: ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Text(
                            DateUtil.getLastMessageTime(
                                context: context,
                                time: widget.user?.lastActive ?? '',
                                showYear: true),
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15)),
                      ],
                    )
                  : null,

          //body
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(height: 300),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      imageUrl: widget.user != null
                          ? widget.user?.image ?? ''
                          : widget.group?.groupImage ?? '',
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),

                  // for adding some space
                  SizedBox(height: 300),

                  // user email label
                  Text(
                      widget.user != null ? widget.user?.phoneNumber ?? '' : '',
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16)),

                  // for adding some space
                  SizedBox(height: 200),

                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user?.about ?? '',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
