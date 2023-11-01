import 'package:flutter/material.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app_controller.dart';
import 'setting_controller.dart';

class AboutAppScreen extends StatelessWidget {
  final SettingController settingController = Get.find();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Scan QR Code'.tr),
        backgroundColor: appController.isDarkModeOn.value
            ? Color(0xFF233142)
            : ColorConstants.backgroundColorButtonGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child:
                      Lottie.asset('assets/icons/img_scan_qr_code_app.json')),
              SizedBox(
                height: 10,
              ),
              Text(
                'Scan QR Code'.tr,
                style: CustomTextStyles.labelBlack500Size24Fw600,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                '${'Version'.tr} ${settingController.versionCode}',
                style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? appTheme.gray100
                        : ColorConstants.blackText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'contentAboutAppFirst'.tr,
                style: TextStyle(
                  color: appController.isDarkModeOn.value
                      ? appTheme.gray100
                      : ColorConstants.grey800,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("keyFeature".tr,
                    style: CustomTextStyles.labelBlack500Size18Fw600),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "contentKeyFeatureFirst".tr,
                      style: CustomTextStyles.labelGray600Size14Fw600,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "contentKeyFeatureTow".tr,
                      style: CustomTextStyles.labelGray600Size14Fw600,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "contentKeyFeatureThree".tr,
                      style: CustomTextStyles.labelGray600Size14Fw600,
                    ),
                    Text(
                      "contentKeyFeatureFor".tr,
                      style: CustomTextStyles.labelGray600Size14Fw600,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "contentAboutAppp".tr,
                style: CustomTextStyles.labelBlack500Size18Fw600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
