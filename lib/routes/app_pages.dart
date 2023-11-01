import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/contact_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/email_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/location_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/phone_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/sms_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/temporary_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/create_qr/web_link_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/other_scan/code_128_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/other_scan/code_39_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/other_scan/code_93_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/other_scan/ean_13_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/component/other_scan/ean_8_screen.dart';
import 'package:flutter_getx_base/modules/main/create_qr_code/create_qr_code.dart';
import 'package:flutter_getx_base/modules/main/favorites/favorites_binding.dart';
import 'package:flutter_getx_base/modules/main/favorites/favorites_screen.dart';
import 'package:flutter_getx_base/modules/main/history/history_binding.dart';
import 'package:flutter_getx_base/modules/main/history/history_screen.dart';
import 'package:flutter_getx_base/modules/main/my_qr_code/my_qr_code.dart';
import 'package:flutter_getx_base/modules/main/payment_screen/payment_screen.dart';
import 'package:flutter_getx_base/modules/main/scan_detail/scan_detail.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_biding.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_screen.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/about_app_screen.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_binding.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_screen.dart';
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
      name: Routes.MY_QR_CODE_SCREEN,
      page: () => MyQrCodeScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.QR_CODE,
      page: () => ScanQRCodeScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.FAVOTITES_SCREEN,
      page: () => FavoriteScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.HISTORY_SCREEN,
      page: () => HistoryScreen(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Routes.TEMPORARY_SCREEN,
      page: () => TemporaryScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.CREATE_QR_CODE_SCREEN,
      page: () => CreateQrCodeScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_SCREEN,
      page: () => LocationScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.WEB_LINK,
      page: () => WebLinkScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_SCREEN,
      page: () => ContactScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.EMAIL_SCREEN,
      page: () => EmailScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.SMS_SCREEN,
      page: () => SMSScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.PHONE_SCREEN,
      page: () => PhoneScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.EAN8_SCREEN,
      page: () => Ean8Screen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.EAN13_SCREEN,
      page: () => Ean13Screen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.CODE39_SCREEN,
      page: () => Code39Screen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.CODE93_SCREEN,
      page: () => Code93Screen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.CODE128_SCREEN,
      page: () => Code128Screen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.SCAN_DETAIL_SCREEN,
      page: () => ScanDetailScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.SETTING_SCREEN,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.ABOUT_APP_SCREEN,
      page: () => AboutAppScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.PAYMENT_SCREEN,
      page: () => PaymentScreen(),
      binding: SettingBinding(),
    ),
  ];
}
