import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryViewScreen extends StatefulWidget {
  final imageUrl;

  const StoryViewScreen({super.key,this.imageUrl});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  // late final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story'),
      ),
      body: Center(
        child: widget.imageUrl.isNotEmpty
            ? Image.network(widget.imageUrl)
            : Text('No image available'),
      ),
    );
  }
}