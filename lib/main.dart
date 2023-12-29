import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:flutter/material.dart';

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
      initialRoute: RouteConstants.chatScreen,
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
