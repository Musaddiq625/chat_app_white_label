import 'package:chat_app_white_label/src/components/ui_scaffold.dart';
import 'package:chat_app_white_label/src/constants/image_constants.dart';
import 'package:flutter/material.dart';

class LocalsAppScreen extends StatefulWidget {
  const LocalsAppScreen({super.key});

  @override
  State<LocalsAppScreen> createState() => _LocalsAppScreenState();
}

class _LocalsAppScreenState extends State<LocalsAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const UIScaffold(
        bgImage: AssetConstants.backgroundImage,
        widget: Column(
          children: [Text('data')],
        ));
  }
}
