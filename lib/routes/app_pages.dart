import 'package:flutter_getx_base/modules/main/change_language/change_language_binding.dart';
import 'package:flutter_getx_base/modules/main/change_language/change_language_screen.dart';
import 'package:flutter_getx_base/modules/main/history/history_binding.dart';
import 'package:flutter_getx_base/modules/main/history/history_screen.dart';
import 'package:flutter_getx_base/modules/main/home_binding.dart';
import 'package:flutter_getx_base/modules/main/home_screen.dart';
import 'package:flutter_getx_base/modules/main/payment_screen/payment_screen.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_binding.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_screen.dart';
import 'package:flutter_getx_base/modules/main/stylize/stylize_screen.dart';
import 'package:flutter_getx_base/modules/splash/splash_binding.dart';
import 'package:flutter_getx_base/modules/splash/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HISTORY_SCREEN,
      page: () => HistoryScreen(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.SETTING_SCREEN,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_SCREEN,
      page: () => PaymentScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.STYLIZE_SCREEN,
      page: () => StylizeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_LANGUAGE,
      page: () => ChangeLanguage(),
      binding: ChangeLanguageBinding(),
    ),
  ];
}
