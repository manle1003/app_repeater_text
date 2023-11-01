part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const AUTH = '/auth';
  static const LOG_IN = '/log_in';

  static const HOME = '/home';
  static const QR_CODE = '/qr_code';
  static const FAVOTITES_SCREEN = '/favorites_screen';
  static const MY_QR_CODE_SCREEN = '/my_qr_code_screen';
  static const HISTORY_SCREEN = '/history_screen';
  static const SCAN_DETAIL_SCREEN = '/scan_detail_screen';
  static const SETTING_SCREEN = '/setting_screen';
  static const ABOUT_APP_SCREEN = '/about_app_screen';
  static const PAYMENT_SCREEN = '/payment_screen';

  // Create QR Code
  static const CREATE_QR_CODE_SCREEN = '/create_qr_code_screen';
  static const TEMPORARY_SCREEN = '/temporary_Screen';
  static const WEB_LINK = '/web_link';
  static const TEXT_SCREEN = '/text_screen';
  static const CONTACT_SCREEN = '/contact_screen';
  static const EMAIL_SCREEN = '/email_screen';
  static const SMS_SCREEN = '/sms_screen';
  static const LOCATION_SCREEN = '/location_screen';
  static const PHONE_SCREEN = '/phone_screen';
  static const CALENDER_SCREEN = '/calendar_screen';

  // Create QR Code Other
  static const EAN8_SCREEN = '/ean8_screen';
  static const EAN13_SCREEN = '/ean13_screen';
  static const CODE39_SCREEN = '/code39_screen';
  static const CODE93_SCREEN = '/code93_screen';
  static const CODE128_SCREEN = '/code128_screen';
}
