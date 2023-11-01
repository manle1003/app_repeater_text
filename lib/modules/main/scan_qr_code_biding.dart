import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:get/get.dart';

class ScanQrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrCodeController>(() => ScanQrCodeController());
  }
}
