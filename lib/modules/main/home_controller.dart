import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/constants/common.dart';
import '../../shared/widgets/common_widget.dart';
import 'components/constants_common.dart';

class HomeController extends GetxController {
  DateTime? currentBackPressTime;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final fieldText = TextEditingController();
  final TextEditingController countText = TextEditingController();

  Rx<int> countItems = 0.obs;
  Rx<String> textRow = ''.obs;
  Rx<String> styleFont = ''.obs;
  RxList listItems = [].obs;
  final RxBool isChecked = false.obs;
  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();

  @override
  void onInit() {
    countText.text = '10';
    super.onInit();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;
      CommonWidget.toast(CommonConstants.tittleExitApp.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> copyText(String qrCodeData) async {
    Clipboard.setData(
      ClipboardData(
        text: qrCodeData,
      ),
    );
    Get.snackbar(
      ConstantsCommon.copy.tr,
      ConstantsCommon.copySuccess.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(milliseconds: 700),
    );
  }

  void viewListRepeat() {
    countItems.value = int.tryParse(countText.text) ?? 0;
    if (countItems.value < 0 || countItems.value > 1000) countItems.value = 0;
    listItems.value =
        List<String>.generate(countItems.value, (index) => fieldText.text);
    textRow.value = '';
    for (var i = 0; i < countItems.value; i++) {
      textRow.value += '${fieldText.text} ';
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void clearText() {
    fieldText.clear();
    listItems.clear();
  }
}
