import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:odm/screens/sign/screen_sign_in.dart';
import 'package:odm/screens/splash/screen_splash.dart';

class Routers {
  final allPageRouter = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
  ];
}
