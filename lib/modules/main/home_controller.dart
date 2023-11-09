import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_base/modules/main/components/ads/ad_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../shared/constants/common.dart';
import '../../shared/widgets/common_widget.dart';
import 'components/constants_common.dart';

class HomeController extends GetxController {
  DateTime? currentBackPressTime;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final fieldText = TextEditingController();
  final TextEditingController countText = TextEditingController();
  final GlobalKey<FormState> textLooperFormKey = GlobalKey<FormState>();

  Rx<int> countItems = 0.obs;
  Rx<String> textRow = ''.obs;
  Rx<String> styleFont = ''.obs;
  RxList listItems = [].obs;
  final RxBool isChecked = false.obs;
  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();
  NativeAd? nativeAd;
  final RxBool nativeAdIsLoaded = false.obs;
  @override
  void onInit() {
    countText.text = '10';
    isShowAdsNative();
    super.onInit();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;
      CommonWidget.toast(CommonConstants.tittleExitApp.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> copyText(String qrCodeData) async {
    Clipboard.setData(
      ClipboardData(
        text: qrCodeData,
      ),
    );
    Get.snackbar(
      ConstantsCommon.copy.tr,
      ConstantsCommon.copySuccess.tr,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(milliseconds: 700),
    );
  }

  void viewListRepeat() {
    if (textLooperFormKey.currentState!.validate()) {
      countItems.value = int.tryParse(countText.text) ?? 0;
      if (countItems.value < 0 || countItems.value > 1000) countItems.value = 0;
      String textField = fieldText.text.trim();
      listItems.value =
          List<String>.generate(countItems.value, (index) => textField.trim());
      textRow.value = '';
      for (var i = 0; i < countItems.value; i++) {
        textRow.value += '${fieldText.text.trim()} ';
      }
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void clearText() {
    fieldText.clear();
    listItems.clear();
    textRow.value = '';
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
}
