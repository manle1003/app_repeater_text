import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app_controller.dart';
import '../components/drawer.dart';
import 'setting_controller.dart';

class AboutAppScreen extends StatelessWidget {
  final SettingController settingController = Get.find();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: DrawerBarScreen(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(ConstantsCommon.textLooper.tr),
          backgroundColor: appController.isDarkModeOn.value
              ? Color(0xFF233142)
              : settingController.isCheckColors.value,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: Lottie.asset('assets/svgs/lt_text_looper.json')),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ConstantsCommon.aboutUs.tr,
                  style: CustomTextStyles.labelBlack500Size24Fw600,
                ),
                SizedBox(
                  height: 6,
                ),
                Obx(
                  () => Text(
                    '${ConstantsCommon.version.tr} ${settingController.versionCode}',
                    style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? appTheme.gray100
                            : ColorConstants.blackText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  ConstantsCommon.contentAboutAppFirst.tr,
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
                  child: Text(ConstantsCommon.keyFeature.tr,
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
                        ConstantsCommon.contentKeyFeatureFirst.tr,
                        style: CustomTextStyles.labelGray600Size14Fw600,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        ConstantsCommon.contentKeyFeatureTow.tr,
                        style: CustomTextStyles.labelGray600Size14Fw600,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        ConstantsCommon.contentKeyFeatureThree.tr,
                        style: CustomTextStyles.labelGray600Size14Fw600,
                      ),
                      Text(
                        ConstantsCommon.contentKeyFeatureFor.tr,
                        style: CustomTextStyles.labelGray600Size14Fw600,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ConstantsCommon.contentAboutAppp.tr,
                  style: CustomTextStyles.labelBlack500Size18Fw600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
