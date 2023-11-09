// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/home_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import '../../app_controller.dart';
import '../../shared/widgets/input_field.dart';
import 'components/constants_common.dart';
import 'setting_screen/setting_controller.dart';

class HomeScreen extends GetView<HomeController> {
  final AppController appController = Get.find();
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: controller.scaffoldKey,
          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: DrawerBarScreen(),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Transform.scale(
                scale: 0.7,
                child: SvgPicture.asset(
                  'assets/icons/ic_menu_vip.svg',
                  color: ColorConstants.white,
                ),
              ),
              onPressed: () {
                controller.openDrawer();
              },
            ),
            centerTitle: true,
            title: Text(
              ConstantsCommon.home.tr,
              style: CustomTextStyles.labelWhite700Size18Fw600,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: ColorConstants.white,
                ),
                onPressed: () {
                  Share.share(
                    "I'm using this incredibly convenient Repeat Text app. You should give it a try!",
                  );
                },
              ),
            ],
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                    top: 20,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          ConstantsCommon.enterText.tr,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Form(
                        key: controller.textLooperFormKey,
                        child: InputField(
                          checkBackgroundColorTextfield: true,
                          hintText: ConstantsCommon.typeContent.tr,
                          suffixIcon: IconButton(
                            onPressed: controller.clearText,
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ConstantsCommon.required.tr;
                            }
                            return null;
                          },
                          controller: controller.fieldText,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InputField(
                              hintText: '',
                              keyboardType: TextInputType.number,
                              checkBackgroundColorTextfield: true,
                              controller: controller.countText,
                            ),
                          ),
                          Obx(
                            () => Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: appTheme.gray400,
                                    ),
                                    child: Checkbox.adaptive(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                      ),
                                      value: controller.isChecked.value,
                                      onChanged: (bool? value) {
                                        controller.isChecked.value = value!;
                                      },
                                      activeColor: ColorConstants
                                          .backgroundColorButtonGreen,
                                      checkColor:
                                          ColorConstants.backgroundColor,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      ConstantsCommon.repeatNewLine.tr,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          controller.viewListRepeat();
                        },
                        child: Text(
                          ConstantsCommon.repeatText.tr,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.backgroundColorButtonGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Container(
                          height: 360,
                          decoration: BoxDecoration(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.grey800
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: controller.isChecked.value
                                    ? Scrollbar(
                                        child: ListView.builder(
                                          itemExtent: 30,
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          itemCount:
                                              controller.listItems.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Obx(
                                              () => ListTile(
                                                title: Text(
                                                  controller.listItems[index],
                                                  style: controller.styleFont
                                                              .value ==
                                                          ''
                                                      ? CustomTextStyles
                                                          .labelBlack500Size16Fw500
                                                      : GoogleFonts.getFont(
                                                          controller
                                                              .styleFont.value,
                                                        ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Scrollbar(
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                controller.textRow.value,
                                                style: controller
                                                            .styleFont.value ==
                                                        ''
                                                    ? CustomTextStyles
                                                        .labelBlack500Size16Fw500
                                                    : GoogleFonts.getFont(
                                                        controller
                                                            .styleFont.value,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildButton(
                                      icon: Icons.copy,
                                      text: ConstantsCommon.copy.tr,
                                      onPressed: () {
                                        String concatenatedText =
                                            controller.listItems.join(" ");
                                        if (concatenatedText.isNotEmpty) {
                                          controller.copyText(concatenatedText);
                                        }
                                      },
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                  ),
                                  Expanded(
                                    child: buildButton(
                                      icon: Icons.share,
                                      text: ConstantsCommon.share.tr,
                                      onPressed: () {
                                        String concatenatedText =
                                            controller.listItems.join(" ");
                                        if (concatenatedText.isNotEmpty)
                                          Share.share(concatenatedText);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: buildButton(
                                      icon: Icons.brush_outlined,
                                      text: ConstantsCommon.stylize.tr,
                                      onPressed: () {
                                        if (controller.listItems.isNotEmpty) {
                                          Get.toNamed(
                                            Routes.STYLIZE_SCREEN,
                                            arguments: controller.listItems[0],
                                          );
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(alignment: Alignment.bottomCenter, child: isShowAdsNative())
            ],
          ),
        ),
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

// Function to create a reusable button
  Widget buildButton({
    IconData? icon,
    String? text,
    VoidCallback? onPressed,
    BorderRadius? borderRadius,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getSize(50),
        decoration: BoxDecoration(
          color: Color(0xFF0ac775),
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  text!,
                  style: TextStyle(color: Colors.white),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
