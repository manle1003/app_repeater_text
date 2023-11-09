import 'package:flutter_getx_base/modules/main/app_in_house/app_in_house_controller.dart';
import 'package:get/get.dart';

class AppInHouseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppInHouseController>(() => AppInHouseController());
  }
}
