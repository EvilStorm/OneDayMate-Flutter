import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:odm/binders/binder_home.dart';
import 'package:odm/binders/binder_join_process.dart';
import 'package:odm/binders/binder_posting.dart';
import 'package:odm/screens/home/screen_home.dart';
import 'package:odm/screens/join/screen_process_join.dart';
import 'package:odm/screens/mate_post/screen_mate_posting.dart';
import 'package:odm/screens/sign/screen_sign_in.dart';
import 'package:odm/screens/splash/screen_splash.dart';

class Routers {
  final allPageRouter = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
    GetPage(
        name: '/joinProcess',
        page: () => JoinProcessScreen(),
        binding: JoinProcessBinder()),
    GetPage(
      name: '/home',
      page: () => HomeScreen(),
      binding: HomeBinder(),
    ),
    GetPage(
        name: '/mating/create',
        page: () => MatePostingScreen(),
        binding: PostingBinder()),
  ];
}
