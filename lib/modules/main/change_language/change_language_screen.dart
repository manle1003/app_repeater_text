import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../components/drawer.dart';
import 'change_language_controller.dart';
import 'language_widget.dart';

class ChangeLanguage extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find();
    final SettingController settingController = Get.put(SettingController());

    return Scaffold(
      drawer: DrawerBarScreen(),
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() => Text(controller.languageTitle.value)),
        backgroundColor: appController.isDarkModeOn.value
            ? Color(0xFF233142)
            : settingController.isCheckColors.value,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 120),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      LanguageWidget(
                          flag: '🇺🇸',
                          label: 'ENGLISH',
                          locale: 'en',
                          index: 0),
                      LanguageWidget(
                          flag: '🇻🇳',
                          label: 'VIỆT NAM',
                          locale: 'vi',
                          index: 1),
                      LanguageWidget(
                        flag: '🇰🇷',
                        label: '한국어',
                        locale: 'ko',
                        index: 2,
                      ),
                      LanguageWidget(
                        flag: '🇨🇳',
                        label: '中文',
                        locale: 'cn',
                        index: 3,
                      ),
                      LanguageWidget(
                          flag: '🇦🇹',
                          label: 'ÖSTERREICH DEUTSCH',
                          locale: 'de_AT',
                          index: 4),
                      LanguageWidget(
                          flag: '🇩🇪',
                          label: 'DEUTSCH',
                          locale: 'de',
                          index: 5),
                      LanguageWidget(
                          flag: '🇬🇷',
                          label: 'ΕΛΛΗΝΙΚΑ',
                          locale: 'el',
                          index: 6),
                      LanguageWidget(
                          flag: '🇪🇸',
                          label: 'ESPAÑOL',
                          locale: 'es',
                          index: 7),
                      LanguageWidget(
                          flag: '🇫🇷',
                          label: 'FRANÇAIS',
                          locale: 'fr',
                          index: 8),
                      LanguageWidget(
                          flag: '🇭🇷',
                          label: 'HRVATSKI',
                          locale: 'hr',
                          index: 9),
                      LanguageWidget(
                          flag: '🇭🇺',
                          label: 'MAGYAR',
                          locale: 'hu',
                          index: 10),
                      LanguageWidget(
                          flag: '🇮🇹',
                          label: 'ITALIANO',
                          locale: 'it',
                          index: 11),
                      LanguageWidget(
                          flag: '🇯🇵', label: '日本語', locale: 'jp', index: 12),
                      LanguageWidget(
                          flag: '🇳🇱',
                          label: 'NEDERLANDS',
                          locale: 'nl',
                          index: 13),
                      LanguageWidget(
                          flag: '🇵🇱',
                          label: 'POLSKI',
                          locale: 'pl',
                          index: 14),
                      LanguageWidget(
                          flag: '🇧🇷',
                          label: 'PORTUGUÊS (BRASIL)',
                          locale: 'ptBR',
                          index: 15),
                      LanguageWidget(
                          flag: '🇷🇴',
                          label: 'LIMBA ROMÂNĂ',
                          locale: 'ro',
                          index: 16),
                      LanguageWidget(
                          flag: '🇷🇺',
                          label: 'РУССКИЙ',
                          locale: 'ru',
                          index: 17),
                      LanguageWidget(
                          flag: '🇹🇷',
                          label: 'TÜRKÇE',
                          locale: 'tr',
                          index: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: isShowAdsNative())
        ],
      ),
    );
  }

  Widget isShowAdsNative() {
    final SettingController settingController = Get.find();
    AdWidget adWidget =
        AdWidget(key: UniqueKey(), ad: controller.isShowAdsNative());
    return Obx(
      () => settingController.isCheckedRemoveAds.value
          ? const SizedBox()
          : controller.nativeAdIsLoaded.value
              ? Container(
                  height: 100,
                  child: adWidget,
                )
              : SizedBox.shrink(),
    );
  }
}
