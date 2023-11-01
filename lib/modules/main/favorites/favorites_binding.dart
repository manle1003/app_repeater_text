import 'package:flutter_getx_base/modules/main/favorites/favorites_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ScanQrCodeController>(() => ScanQrCodeController());
  }
}
