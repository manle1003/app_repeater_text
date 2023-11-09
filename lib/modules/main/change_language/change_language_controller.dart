import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../shared/sharepreference/sharepreference.dart';
import '../components/ads/ad_helper.dart';


class ChangeLanguageController extends GetxController {
  Rx<int> indexChangeLanguage = 0.obs;
  Rx<String> locateChangeLanguage = 'en'.obs;
  Rx<String> languageTitle = 'English'.obs;

  void getIndexChangeLanguage() async {
    indexChangeLanguage.value =
        await SharedPreferencesManager.instance.getIndexChangeLanguage();
    languageTitle.value =
        await SharedPreferencesManager.instance.getLocalTitleChangeLanguage();
  }

  NativeAd? nativeAd;
  final RxBool nativeAdIsLoaded = false.obs;

  @override
  void onInit() {
    isShowAdsNative();
    getIndexChangeLanguage();

    super.onInit();
  }

  NativeAd isShowAdsNative() {
    return NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdIsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) {
          ad.dispose();
          print('Ad closed: ${ad.adUnitId}.');
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    )..load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}
