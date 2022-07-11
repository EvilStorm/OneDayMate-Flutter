import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odm/controllers/contoller_user_info.dart';
import 'package:odm/controllers/controller_email_sign_in.dart';
import 'package:odm/controllers/controller_third_party_signin.dart';
import 'package:odm/firebase_options.dart';
import 'package:odm/routers.dart';
import 'package:odm/theme.dart';

import 'controllers/controller_sign.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(SignController());
    Get.put(UserInfoController());
    Get.put(ThirdPartySignInController());
    Get.put(EmailSignInController());

    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
      title: 'StyleMate',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: Routers().allPageRouter,
      theme: Themes.lightTheme,
    );
  }
}
