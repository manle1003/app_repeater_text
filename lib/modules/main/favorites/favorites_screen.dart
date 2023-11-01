// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/favorites/favorites_controller.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../app_controller.dart';
import '../components/drawer.dart';
import '../setting_screen/setting_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({super.key});

  final AppController appController = Get.find();
  final ScanQrCodeController scanQrCodeController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  final List<QRCode> listQRCode = [];
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getListFavoriteData();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(ConstantsCommon.feedback.tr),
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () {},
            // ),
          ),
        ),
      ),
    );
  }
}
