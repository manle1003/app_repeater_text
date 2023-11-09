// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/app_in_house/app_in_house.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';

import 'package:get/get.dart';

import '../../../app_controller.dart';
import '../components/drawer.dart';
import '../setting_screen/setting_controller.dart';

class AppInHouseScreen extends GetView<AppInHouseController> {
  AppInHouseScreen({super.key});

  final AppController appController = Get.find();
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
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(ConstantsCommon.appInHouse.tr),
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    ItemApp(
                    nameApp: 'QR Scanner and Generator',
                    description: ConstantsCommon.description_app_01.tr,
                    imageApp: 'assets/icons/ic_logo_easy_scan.jpeg',
                    numbUser: '332,354',
                    linkStore:
                        'https://play.google.com/store/apps/details?id=com.pixel.codescanner',
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  ItemApp(
                    nameApp: 'QR Scanner and Generator Pro',
                    description: ConstantsCommon.description_app_01.tr,
                    imageApp: 'assets/icons/ic_logo_easy_scan.jpeg',
                    numbUser: '332,127',
                    linkStore:
                        'https://play.google.com/store/apps/details?id=com.pixel.codescannerpro',
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  ItemApp(
                    nameApp: 'Ez Card Scanner',
                    description: ConstantsCommon.description_app_02.tr,
                    imageApp: 'assets/icons/ic_ez_card_scanner.jpeg',
                    numbUser: '325,786',
                    linkStore:
                        'https://play.google.com/store/apps/details?id=com.pixel.ezcardscanner',
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  ItemApp(
                    nameApp: 'Ez Card Scanner Pro',
                    description: ConstantsCommon.description_app_03.tr,
                    imageApp: 'assets/icons/ic_ez_card_scanner.jpeg',
                    numbUser: '212,578',
                    linkStore:
                        'https://play.google.com/store/apps/details?id=com.pixel.ezcardscannerpro',
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

// ignore: must_be_immutable
class ItemApp extends StatelessWidget {
  String nameApp;
  String description;
  String imageApp;
  String numbUser;
  String linkStore;
  ItemApp({
    required this.nameApp,
    required this.description,
    required this.imageApp,
    required this.numbUser,
    required this.linkStore,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppInHouseController appInHouseController = Get.find();
    final AppController appController = Get.find();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: appController.isDarkModeOn.value
            ? ColorConstants.grey800
            : ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: getSize(64),
                  height: getSize(64),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      imageApp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nameApp,
                        style: CustomTextStyles.labelBlack500Size18Fw600,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Nine Plus',
                        style: CustomTextStyles.labelGray600Size14Fw400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: CustomTextStyles.labelBlack500Size18Fw400,
            ),
          ),
          SizedBox(
            height: getSize(16),
          ),
          Image.asset(
            imageApp,
            width: double.infinity,
            height: getSize(200),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: getSize(16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ConstantsCommon.downloadapp.tr,
                        style: CustomTextStyles.labelBlack500Size18Fw600,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                      Text(
                        "$numbUser ${ConstantsCommon.peopleUseThis.tr}",
                        style: CustomTextStyles.labelBlack500Size18Fw400,
                      ),
                      SizedBox(
                        height: getSize(8),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      appInHouseController.launchURL(linkStore);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.darkGray,
                          width: .5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Center(
                        child: Text(
                          ConstantsCommon.useapp.tr,
                          style: CustomTextStyles.labelBlack500Size18Fw400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
