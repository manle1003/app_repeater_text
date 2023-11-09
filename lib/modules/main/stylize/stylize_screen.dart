import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/home_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../setting_screen/setting_controller.dart';

class StylizeScreen extends StatefulWidget {
  @override
  State<StylizeScreen> createState() => _StylizeScreenState();
}

class _StylizeScreenState extends State<StylizeScreen> {
  final HomeController homeController = Get.find();

  final String text = Get.arguments;

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ConstantsCommon.stylize.tr,
          style: CustomTextStyles.labelWhite700Size18Fw600,
        ),
        backgroundColor: ColorConstants.backgroundColorButtonGreen,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemExtent: 50,
                    itemCount: 120,
                    itemBuilder: (context, index) {
                      final fontFamily = homeController.fontFamilies[index];
                      return InkWell(
                        onTap: () {
                          homeController.styleFont.value = fontFamily;
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorConstants.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    text,
                                    style: GoogleFonts.getFont(fontFamily),
                                  ),
                                  Icon(
                                    homeController.styleFont.value == fontFamily
                                        ? Icons.done
                                        : Icons.done_outline,
                                    color: homeController.styleFont.value ==
                                            fontFamily
                                        ? ColorConstants
                                            .backgroundColorButtonGreen
                                        : Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
        AdWidget(key: UniqueKey(), ad: homeController.isShowAdsNative());
    return Obx(
      () => settingController.isCheckedRemoveAds.value
          ? const SizedBox()
          : homeController.nativeAdIsLoaded.value
              ? Container(
                  height: 100,
                  child: adWidget,
                )
              : SizedBox.shrink(),
    );
  }
}
