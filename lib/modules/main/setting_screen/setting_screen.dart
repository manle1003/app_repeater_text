// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/components/user_profile_setting_groups.dart';
import 'package:flutter_getx_base/modules/main/components/user_profile_setting_item.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/widgets/show_dialog_upgrade.dart';
import '../../../theme/theme_helper.dart';

class SettingScreen extends GetView<SettingController> {
  final TextEditingController _upgradeProController = TextEditingController();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.QR_CODE);
          return true;
        },
        child: Scaffold(
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : controller.isCheckColors.value,
            title: Text(
              ConstantsCommon.setting.tr,
              style: TextStyle(color: ColorConstants.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text(
                        ConstantsCommon.colorBoard.tr,
                        style: CustomTextStyles.labelBlack500Size18Fw600,
                      ),
                      SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0;
                                i < controller.listColors.length;
                                i++)
                              GestureDetector(
                                onTap: () async {
                                  controller.listCheckStatus[i] = true;
                                  SharedPreferencesManager.instance
                                      .setInt('isCheckBox', i);
                                  for (int j = 0;
                                      j < controller.listCheckStatus.length;
                                      j++) {
                                    if (j != i) {
                                      controller.listCheckStatus[j] = false;
                                    }
                                  }
                                  controller.isCheckColors.value =
                                      controller.listColors[i];
                                  await SharedPreferencesManager.instance
                                      .saveColorToPreferences("isCheckColors",
                                          controller.isCheckColors.value);

                                  controller.setDefaultDecoration();
                                },
                                child: boxThemeColorCustom(
                                  isCheck: controller.listCheckStatus[i],
                                  colors: controller.listColors[i],
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      BuildSettingsGroup(
                        settingsGroupTitle: ConstantsCommon.theme.tr,
                        items: [
                          BuildSettingsItem(
                            imageAsset: ImageConstant.iconVibration,
                            widgetTitle: Text(
                              ConstantsCommon.vibrations.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Obx(
                              () => Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                      controller.isCheckColors.value,
                                ),
                                child: Checkbox.adaptive(
                                  value: controller.isChecked.value,
                                  onChanged: (bool? value) {
                                    controller.isChecked.value = value!;
                                    controller.isCheckVibration.value =
                                        controller.isChecked.value;
                                  },
                                  activeColor: controller.isCheckColors.value,
                                  checkColor: ColorConstants.white,
                                ),
                              ),
                            ),
                          ),
                          BuildSettingsItem(
                            onTap: () {},
                            // Get.toNamed(Routes.EDIT_PROFILE,
                            //     arguments: myController),
                            imageAsset: ImageConstant.iconAboutUs,
                            widgetTitle: Text(
                              ConstantsCommon.darkMode.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Obx(
                              () => Switch(
                                value: appController.isDarkModeOn.value,
                                activeTrackColor:
                                    appController.isDarkModeOn.value
                                        ? Colors.white
                                        : Colors.blueGrey,
                                activeColor: appController.isDarkModeOn.value
                                    ? Colors.white
                                    : Colors.lightBlue,
                                onChanged: (value) {
                                  appController.toggleDarkMode();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      BuildSettingsGroup(
                        settingsGroupTitle: ConstantsCommon.system.tr,
                        items: [
                          BuildSettingsItem(
                            onTap: () {
                              Get.toNamed(Routes.CHANGE_LANGUAGE);
                            },
                            // Get.toNamed(Routes.EDIT_PROFILE,
                            //     arguments: myController),
                            imageAsset: ImageConstant.iconLanguage,
                            widgetTitle: Text(
                              ConstantsCommon.changeLanguage.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            isIconLanguage: false,
                          ),
                          BuildSettingsItem(
                            onTap: () {
                              Share.share(
                                "I'm using this incredibly convenient QR code and barcode scanning app. You should give it a try!",
                              );
                            },
                            imageAsset: ImageConstant.iconShare,
                            widgetTitle: Text(
                              ConstantsCommon.share.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BuildSettingsItem(
                            onTap: () => Get.toNamed(
                              Routes.ABOUT_APP_SCREEN,
                            ),
                            imageAsset: ImageConstant.iconAboutUs,
                            widgetTitle: Text(
                              ConstantsCommon.repeatText.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          BuildSettingsItem(
                            onTap: () {
                              controller.isCheckedRemoveAds.value
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ShowDialogUpgrade(
                                          codeController:
                                              controller.removeAdsController,
                                          // themeMode: themeMode,
                                          constGrey: Colors.grey,
                                          hiddenTextField: false,
                                        );
                                      },
                                    )
                                  : Get.offAllNamed(Routes.PAYMENT_SCREEN);
                            },
                            onLongPress: controller.isCheckedRemoveAds.value
                                ? () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ShowDialogUpgrade(
                                          codeController: _upgradeProController,
                                          constGrey: Colors.grey,
                                          hiddenTextField: false,
                                        );
                                      },
                                    )
                                : null,
                            imageAsset: controller.isCheckedRemoveAds.value
                                ? 'assets/icons/ic_scan_pro.svg'
                                : ImageConstant.iconUpgrade,
                            widgetTitle: Text(
                              controller.isCheckedRemoveAds.value
                                  ? 'Easy QR Scanner Pro'
                                  : ConstantsCommon.upgrade.tr,
                              style: CustomTextStyles.labelGray600Size18Fw600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: controller.isCheckedRemoveAds.value
                                ? Lottie.asset(
                                    'assets/icons/pro_version.json',
                                    width: 48,
                                    height: 48,
                                  )
                                : SvgPicture.asset(
                                    ImageConstant.iconArrowRight,
                                    color: appController.isDarkModeOn.value
                                        ? appTheme.whiteA700
                                        : appTheme.gray600,
                                    width: (24),
                                    height: (24),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class boxThemeColorCustom extends StatelessWidget {
  boxThemeColorCustom({
    super.key,
    required this.colors,
    required this.isCheck,
  });

  final Color colors;
  final bool isCheck;

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.check,
          color: isCheck ? ColorConstants.white : Colors.transparent,
        ),
      ),
    );
  }
}
