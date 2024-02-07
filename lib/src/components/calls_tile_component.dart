import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/date_utils.dart';

class CallTileComponent extends StatelessWidget {
  final String name;
  final String image;
  final String videocall;
  final bool? isMissed;
  final bool? inComing;
  final String time;

  const CallTileComponent(
      {super.key,
      required this.name,
      required this.image,
      required this.videocall,
       this.isMissed,
       this.inComing,
      required this.time});

  @override
  Widget build(BuildContext context) {

    String formatRelativeTime(String pastDateString) {
      // Parse the string into a DateTime object
      int unixTimestamp = int.tryParse(pastDateString) ??  0;
      if (unixTimestamp ==  0) {
        return 'Invalid date';
      }

      // Create a DateTime object from the Unix timestamp
      DateTime pastDate = DateTime.fromMillisecondsSinceEpoch(unixTimestamp);

      final now = DateTime.now();
      final difference = now.difference(pastDate);

      if (difference.inSeconds <=  60) {
        return 'just now';
      } else if (difference.inMinutes <=  60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours <=  24) {
        return '${difference.inHours} hours ago';
      } else if (difference.inDays <=  7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays <=  30) {
        return 'about a month ago';
      } else if (difference.inDays <=  365) {
        return '${difference.inDays ~/  30} months ago';
      } else {
        return 'over a year ago';
      }
    }
    return ListTile(
      leading: image != ''
          ? CircleAvatar(radius: 25, backgroundImage: NetworkImage(image))
          : Icon(
              Icons.account_circle,
              color: Colors.grey.shade500,
              size: 56,
            ),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: Icon(
          //     inComing
          //         ? CupertinoIcons.arrow_down_left
          //         : CupertinoIcons.arrow_up_right,
          //     color: isMissed ? Colors.red : ColorConstants.green,
          //     size: 18,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 4),
            child: Text(formatRelativeTime(time),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
      trailing: Icon(
        videocall == "call" ? Icons.call : Icons.videocam_rounded,
        size: 23,
        color: Colors.teal,
      ),
    );
  }
}
