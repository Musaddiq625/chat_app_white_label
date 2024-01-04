import 'package:chat_app_white_label/src/constants/color_constants.dart';
import 'package:chat_app_white_label/src/constants/route_constants.dart';
import 'package:chat_app_white_label/src/routes/generated_route.dart';
import 'package:chat_app_white_label/src/screens/app_cubit/app_cubit.dart';
import 'package:chat_app_white_label/src/screens/cubit/app_setting_cubit.dart';
import 'package:chat_app_white_label/src/utils/shared_prefrence_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _initRepos();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.green,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

Future<void> _initRepos() async {
  getIt.registerSingleton(SharedPreferencesUtil());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => AppSettingCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'WeUno Chat',
        theme: ThemeData(
          fontFamily: 'Helvetica',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteConstants.splashScreen,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
