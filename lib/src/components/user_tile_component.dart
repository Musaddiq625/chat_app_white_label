import 'package:flutter/material.dart';

class UserTileComponent extends StatelessWidget {
  final String name;
  final String subName;
  final String image;
  final String message;
  const UserTileComponent({
    super.key,
    required this.name,
    required this.subName,
    required this.image,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => ChatRoomScreen(name: name, image: image)),
      // ),
      leading: image != ''
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(image),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.account_circle,
                size: 55,
                color: Colors.grey.shade500,
              ),
            ),
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      // trailing: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(
      //     time,
      //     style: TextStyle(color: Colors.grey.shade500),
      //   ),
      // ),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 19,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Text(
          subName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}
