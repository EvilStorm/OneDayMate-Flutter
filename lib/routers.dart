import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:odm/screens/splash/screen_splash.dart';

class Routers {
  final allPageRouter = [
    GetPage(name: '/', page: () => const SplashScreen()),
  ];
}
