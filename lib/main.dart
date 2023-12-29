import 'package:flutter/material.dart';
import 'package:chat_app_white_label/src/screens/calls_screen.dart';
import 'package:chat_app_white_label/src/screens/chat_screen.dart';
import 'package:chat_app_white_label/src/screens/status_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ChatScreen.id,
      routes: {
        ChatScreen.id: (ctx) => const ChatScreen(),
        StatusScreen.id: (ctx) => const StatusScreen(),
        CallScreen.id: (ctx) => const CallScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
