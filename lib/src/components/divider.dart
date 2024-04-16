import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.75,
      endIndent: 10,
      indent: 60,
    );
  }
}
