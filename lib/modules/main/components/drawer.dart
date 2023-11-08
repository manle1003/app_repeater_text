// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/lang/translation_service.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/home_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class DrawerBarScreen extends StatelessWidget {
  final SettingController settingController = Get.put(SettingController());
  final HomeController homeController =
      Get.put(HomeController ());
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return homeController.onWillPop();
      },
      child: SafeArea(
        child: Drawer(
          width: MediaQuery.of(context).size.width * .7,
          child: Obx(
            () => ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildListTile(
                    0, ConstantsCommon.home.tr, 'assets/icons/scan.svg', () {
                  settingController.isCheckDrawer.value = 0;
                  Get.offAllNamed(Routes.QR_CODE);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(1, ConstantsCommon.share.tr,
                    'assets/icons/img_galary.svg', () {
                  settingController.isCheckDrawer.value = 1;
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(2, ConstantsCommon.feedback.tr,
                    'assets/icons/img_heart.svg', () {
                  settingController.isCheckDrawer.value = 2;
                  Get.offAllNamed(Routes.FAVOTITES_SCREEN);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(3, ConstantsCommon.contactUs.tr,
                    'assets/icons/ic_history.svg', () {
                  settingController.isCheckDrawer.value = 3;
                  Get.offAllNamed(Routes.HISTORY_SCREEN);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(4, ConstantsCommon.changeLanguage.tr,
                    'assets/icons/ic_qr_code.svg', () {
                  settingController.isCheckDrawer.value = 4;
                  Get.offAllNamed(Routes.MY_QR_CODE_SCREEN);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(5, ConstantsCommon.aboutUs.tr,
                    'assets/icons/ic_create_qr.svg', () {
                  settingController.isCheckDrawer.value = 5;
                  Get.offAllNamed(Routes.CREATE_QR_CODE_SCREEN);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(6, ConstantsCommon.termsOfUse.tr,
                    'assets/icons/ic_setting.svg', () {
                  settingController.isCheckDrawer.value = 6;
                  Get.toNamed(Routes.SETTING_SCREEN);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                // _buildListTile(
                //     7, ConstantsCommon.share.tr, ImageConstant.icShare, () {
                //   settingController.isCheckDrawer.value = 7;
                //   Share.share(
                //     "I'm using this incredibly convenient QR code and barcode scanning app. You should give it a try!",
                //   );
                // }),
                // Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(8, ConstantsCommon.privacyPolicy.tr,
                    'assets/icons/ic_about_us.svg', () {
                  settingController.isCheckDrawer.value = 8;
                  Get.toNamed(
                    Routes.ABOUT_APP_SCREEN,
                  );
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(
                  9,
                  ConstantsCommon.credits.tr,
                  'assets/icons/ic_upgrade.svg',
                  () {
                    settingController.isCheckDrawer.value = 9;
                    Get.toNamed(Routes.PAYMENT_SCREEN);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SpeedDialChild> _buildLanguageOptions() {
    return [
      _buildLanguageOption('🇺🇸 English', 'en'),
      _buildLanguageOption('🇻🇳 Vietnamese', 'vi'),
    ];
  }

  SpeedDialChild _buildLanguageOption(String label, String locale) {
    return SpeedDialChild(
      backgroundColor: ColorConstants.primaryColor,
      label: label,
      onTap: () {
        TranslationService.changeLocale(locale);
      },
    );
  }

  Container _buildListTile(
      int index, String title, String iconPath, Function() fuction) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
          color: settingController.isCheckDrawer.value == index
              ? ColorConstants.backgroundColorButtonGreen
              : appController.isDarkModeOn.value
                  ? ColorConstants.lightGray
                  : ColorConstants.black,
        ),
        title: Text(
          title.tr,
          style: TextStyle(
            color: settingController.isCheckDrawer.value == index
                ? ColorConstants.backgroundColorButtonGreen
                : appController.isDarkModeOn.value
                    ? ColorConstants.lightGray
                    : ColorConstants.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: fuction,
      ),
    );
  }
}
