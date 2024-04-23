import 'package:flutter/material.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.1,
      endIndent: 1,
      indent: 0,
    );
  }
}
