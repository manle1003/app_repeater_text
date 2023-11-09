// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/lang/translation_service.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/home_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DrawerBarScreen extends StatelessWidget {
  final SettingController settingController = Get.put(SettingController());
  final HomeController homeController = Get.put(HomeController());
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
                _buildListTile(false, 0, ConstantsCommon.home.tr,
                    ImageConstant.iconBottomHome, () {
                  settingController.isCheckDrawer.value = 0;
                  Get.offAllNamed(Routes.HOME);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(
                    false, 1, ConstantsCommon.share.tr, ImageConstant.icShare,
                    () {
                  settingController.isCheckDrawer.value = 1;
                  Share.share(
                    "I'm using this incredibly convenient Repeat Text app. You should give it a try!",
                  );
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(false, 2, ConstantsCommon.changeLanguage.tr,
                    ImageConstant.iconLanguage, () {
                  settingController.isCheckDrawer.value = 2;
                  Get.offAllNamed(Routes.CHANGE_LANGUAGE);
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(
                  false,
                  3,
                  ConstantsCommon.aboutUs.tr,
                  ImageConstant.iconAboutUs,
                  () {
                    settingController.isCheckDrawer.value = 3;
                    Get.offAllNamed(Routes.ABOUT_APP_SCREEN);
                  },
                ),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(
                  true,
                  4,
                  ConstantsCommon.darkMode.tr,
                  ImageConstant.iconUpgrade,
                  () {
                    settingController.isCheckDrawer.value = 4;
                  },
                ),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(
                  false,
                  5,
                  ConstantsCommon.appInHouse.tr,
                  'assets/icons/ic_ads.svg',
                  () {
                    settingController.isCheckDrawer.value = 5;
                    Get.offAllNamed(Routes.APP_IN_HOUSE);
                  },
                ),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(false, 6, ConstantsCommon.policy.tr,
                    'assets/icons/ic_setting.svg', () {
                  settingController.isCheckDrawer.value = 6;
                  settingController
                      .launchURL('https://sites.google.com/view/textlooper');
                }),
                Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                _buildListTile(false, 7, ConstantsCommon.setting.tr,
                    'assets/icons/ic_setting.svg', () {
                  settingController.isCheckDrawer.value = 7;
                  Get.toNamed(Routes.SETTING_SCREEN);
                }),
                // Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                // _buildListTile(5, ConstantsCommon.aboutUs.tr,
                //     'assets/icons/ic_create_qr.svg', () {
                //   settingController.isCheckDrawer.value = 5;
                //   Get.offAllNamed(Routes.CREATE_QR_CODE_SCREEN);
                // }),

                // Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                // // _buildListTile(
                // //     7, ConstantsCommon.share.tr, ImageConstant.icShare, () {
                // //   settingController.isCheckDrawer.value = 7;
                // //   Share.share(
                // //     "I'm using this incredibly convenient QR code and barcode scanning app. You should give it a try!",
                // //   );
                // // }),
                // // Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                // _buildListTile(8, ConstantsCommon.privacyPolicy.tr,
                //     'assets/icons/ic_about_us.svg', () {
                //   settingController.isCheckDrawer.value = 8;
                //   Get.toNamed(
                //     Routes.ABOUT_APP_SCREEN,
                //   );
                // }),
                // Divider(height: 1, color: Colors.grey.withOpacity(.3)),
                // _buildListTile(
                //   9,
                //   ConstantsCommon.credits.tr,
                //   'assets/icons/ic_upgrade.svg',
                //   () {
                //     settingController.isCheckDrawer.value = 9;
                //     Get.toNamed(Routes.PAYMENT_SCREEN);
                //   },
                // ),
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
    bool isCheckDarkMode,
    int index,
    String title,
    String iconPath,
    Function() function,
  ) {
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
        onTap: function,
        trailing: isCheckDarkMode
            ? Obx(
                () => Switch(
                  value: appController.isDarkModeOn.value,
                  activeTrackColor: appController.isDarkModeOn.value
                      ? Colors.white
                      : Colors.blueGrey,
                  activeColor: appController.isDarkModeOn.value
                      ? Colors.white
                      : Colors.lightBlue,
                  onChanged: (value) {
                    appController.toggleDarkMode();
                  },
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
