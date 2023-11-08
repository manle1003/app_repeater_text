// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/routes.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:get/get.dart';
import '../setting_screen/setting_controller.dart';

class CreateQrCodeScreen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();

  final AppController appController = Get.find();
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
          appBar: AppBar(
            title: Text(
              ConstantsCommon.aboutUs.tr,
            ),
            centerTitle: true,
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          drawer: DrawerBarScreen(),
          body: SingleChildScrollView(
            child: Padding(
              padding: getPadding(all: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Introducing the Repeat Text app - your solution for easily duplicating and generating repeated text sequences. Effortlessly replicate any text or phrase to your desired length with a user-friendly interface. Ideal for testing, content generation, or creative projects. Simply input your text, specify the number of repetitions, and instantly generate the duplicated content. Streamline your workflow and save time with this convenient tool, perfect for writers, developers, designers, and anyone who needs quick, repeated text creation.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
