import 'package:get/get.dart';

import 'history_controller.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HistoryController>(HistoryController());
  }
}
