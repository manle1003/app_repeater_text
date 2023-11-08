// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../components/drawer.dart';

class MyQrCodeScreen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final AppController appController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  final SettingController settingController = Get.put(SettingController());

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
            title: Text(ConstantsCommon.selectLanguage.tr),
            centerTitle: true,
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
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: 5, // Set the number of items you want
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'English',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'English',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
