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
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          key: scanQrCodeController.myQRCodeKey,
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(ConstantsCommon.feedback.tr),
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
            leading: IconButton(
              onPressed: () {
                scanQrCodeController.titleChange.value = "";
                scanQrCodeController.myQRCodeKey.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: appController.isDarkModeOn.value
                        ? Color(0xFF233142)
                        : settingController.isCheckColors.value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.arrow_right_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Text Repeater - Contact Us')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Kindly mention your \nproblem/feedback below!',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Comments/Feedback',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    minLines: 10,
                    maxLines: 15,
                    decoration: InputDecoration(
                      hintText: 'Type your comment/feedback here...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        primary: appController.isDarkModeOn.value
                            ? Color(0xFF233142)
                            : settingController.isCheckColors
                                .value, // Set the button's background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
