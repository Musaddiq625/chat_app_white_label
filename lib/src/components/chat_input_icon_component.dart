import 'package:flutter/material.dart';

class ChatInputIconComponent extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const ChatInputIconComponent({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Icon(icon, color: Colors.white, size: 25),
      ),
    );
  }
}
