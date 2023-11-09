// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  final RxBool isCheckTheme = false.obs;
  final RxBool isCheckDarkModeDisplay = false.obs;
  final RxBool isCheckVibration = false.obs;
  final RxBool isChecked = false.obs;
  final RxBool isCheckedRemoveAds = false.obs;
  final RxInt isCheckDrawer = 0.obs;
  final RxInt isCheckBox = 0.obs;
  final Rx<Color> isCheckColors =
      Rx<Color>(ColorConstants.backgroundColorButtonGreen);

  final RxList<Color> listColors = [
    ColorConstants.backgroundColorButtonGreen,
    ColorConstants.colorDarkModeBlue,
    ColorConstants.blackColor,
    ColorConstants.red,
    ColorConstants.yellowRewardColor,
    ColorConstants.greenLightRewardColor,
    ColorConstants.purpleRewardColor,
  ].obs;
  final TextEditingController removeAdsController = TextEditingController();
  @override
  void onInit() {
    getVersionCode();
    getColor();
    getListCheckStatus();
    getRemoveAds();
    setDefaultDecoration();
    super.onInit();
  }

  RxString versionCode = ''.obs;
  var scaffoldSettingKey = GlobalKey<ScaffoldState>();
  final RxList<bool> listCheckStatus =
      [true, false, false, false, false, false, false].obs;

  void openDrawer() {
    scaffoldSettingKey.currentState?.openDrawer();
  }

  void getListCheckStatus() async {
    isCheckBox.value =
        await SharedPreferencesManager.instance.getInt('isCheckBox') ?? 0;
    for (int i = 0; i < listCheckStatus.length; i++) {
      if (i == isCheckBox.value) {
        listCheckStatus[i] = true;
      } else {
        listCheckStatus[i] = false;
      }
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setDefaultDecoration() async {
    isCheckColors.value = await SharedPreferencesManager.instance
        .loadColorFromPreferences("isCheckColors");
  }

  void getVersionCode() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      versionCode.value = packageInfo.version;
    });
  }

  void getColor() async {
    isCheckColors.value = await SharedPreferencesManager.instance
        .loadColorFromPreferences("isCheckColors");
  }

  void saveRemoveAds(bool isCheck) async {
    final key = "remove_ads";
    await SharedPreferencesManager.instance.setBool(key, isCheck);
    getRemoveAds();
  }

  void getRemoveAds() async {
    isCheckedRemoveAds.value =
        await SharedPreferencesManager.instance.getBool("remove_ads") ?? false;
  }
}
