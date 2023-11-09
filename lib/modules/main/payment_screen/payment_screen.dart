// ignore_for_file: unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/widgets/show_dialog_upgrade.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCheckedYear = true;
  bool isCheckedMonth = false;
  bool isCheckedLife = false;
  String totalPrice = '${'upgradeNow'.tr} \$8.99';

  final _colors = [
    ColorConstants.backgroundColorButtonGreen.withOpacity(.1),
    ColorConstants.backgroundColorButtonGreen.withOpacity(.0),
  ];

  final _durations = [
    0,
    0,
  ];

  final _heightPercentages = [
    0.0,
    0.0,
  ];

  final AppController appController = Get.find();
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = appController.isDarkModeOn.value
        ? Color(0xFF233142)
        : settingController.isCheckColors.value;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        WaveWidget(
                          config: CustomConfig(
                            colors: _colors,
                            durations: _durations,
                            heightPercentages: _heightPercentages,
                          ),
                          backgroundColor: _backgroundColor,
                          size: Size(double.infinity, double.infinity),
                          waveAmplitude: 0,
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          right: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    Get.offAllNamed(Routes.SETTING_SCREEN),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Easy QR Scanner and Generator',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: appTheme.gray100,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Upgrade to Pro Version and Enjoy More Benefits!'
                                      .tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: appTheme.gray100,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isCheckedMonth = false;
                                isCheckedLife = false;
                                isCheckedYear = true;
                                totalPrice = '${'upgradeNow'.tr} \$8.99';
                              });
                            },
                            child: _pakageCart(
                              context,
                              'Remove Ads'.tr,
                              '\$8.99',
                              'one-off'.tr,
                              isCheckedYear,
                            ),
                          )),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isCheckedMonth = false;
                              isCheckedLife = true;
                              isCheckedYear = false;
                              totalPrice =
                                  settingController.isCheckedRemoveAds.value
                                      ? 'freeVersion'.tr
                                      : 'Promote code'.tr;
                            });
                          },
                          child: _pakageCart(
                            context,
                            'Promote code'.tr,
                            'free'.tr,
                            'one-off'.tr,
                            isCheckedLife,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: Text(
                  //     'Voted best card scanner app'.tr,
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       color: appController.isDarkModeOn.value
                  //           ? Colors.white
                  //           : appTheme.black900,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        WaveWidget(
                          config: CustomConfig(
                            colors: _colors,
                            durations: _durations,
                            heightPercentages: _heightPercentages,
                          ),
                          backgroundColor: _backgroundColor,
                          size: Size(double.infinity, double.infinity),
                          waveAmplitude: 0,
                        ),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Text(
                                'Experience the best app without ads'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme.gray100,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Scan QR Code users'.tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme.gray100,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                '5.0',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: appTheme.gray100,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: OverflowBox(
                                  minHeight: 170,
                                  maxHeight: 170,
                                  child:
                                      Lottie.asset('assets/icons/rating.json'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'What you get'.tr,
                    style: TextStyle(
                      fontSize: 22,
                      color: appController.isDarkModeOn.value
                          ? Colors.white
                          : appTheme.gray600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  itemPaymentWidget(
                      'Scan QR Code'.tr,
                      ColorConstants.backgroundColorButtonGreen,
                      'Unlimited'.tr),
                  itemPaymentWidget('Ads', appTheme.whiteA700, 'Free'.tr),
                  // itemPaymentWidget('Integations',
                  //     ColorConstants.backgroundColorButtonGreen, 'Unlimited'),
                  // itemPaymentWidget('Team sharing', appTheme.white),
                  // itemPaymentWidget(
                  //     'Save to contacts'.tr,
                  //     ColorConstants.backgroundColorButtonGreen,
                  //     'Unlimited'.tr),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _ratingCard(
                            context,
                            'assets/icons/imag_duong.jpeg',
                            'Kevin',
                            "commentFirst".tr,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          _ratingCard(
                            context,
                            'assets/icons/imag_johnny.jpeg',
                            'Peter',
                            "commentTwo".tr,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          _ratingCard(
                            context,
                            'assets/icons/imag_quan.png',
                            'Mari',
                            "commentThree".tr,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          _ratingCard(
                            context,
                            'assets/icons/image_david.jpeg',
                            'Johny',
                            "commentFor".tr,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          _ratingCard(
                            context,
                            'assets/icons/image_david.jpeg',
                            'David',
                            "commentFive".tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 48,
                  left: 32,
                  right: 32,
                ),
                decoration: BoxDecoration(
                  color: appController.isDarkModeOn.value
                      ? appTheme.gray200
                      : appTheme.whiteA700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    width: 1.4,
                    color: appTheme.gray200.withOpacity(.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    isCheckedYear
                        ? settingController.launchURL(
                            'https://play.google.com/store/apps/details?id=com.pixel.codescannerpro')
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return ShowDialogUpgrade(
                                codeController:
                                    settingController.removeAdsController,
                                // themeMode: themeMode,
                                constGrey: Colors.grey,
                                hiddenTextField: true,
                              );
                            },
                          );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: appController.isDarkModeOn.value
                          ? Color(0xFF233142)
                          : ColorConstants.backgroundColorButtonGreen,
                    ),
                    child: Center(
                      child: Text(
                        totalPrice,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appTheme.whiteA700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemPaymentWidget(
    String title,
    Color colors,
    String limited,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        minVerticalPadding: 2,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: colors.withOpacity(.06),
        leading: Text(title),
        trailing: Text(
          limited,
          style: TextStyle(
            color: ColorConstants.backgroundColorButtonGreen,
          ),
        ),
      ),
    );
  }

  Widget _pakageCart(
    BuildContext context,
    String title,
    String price,
    String type,
    bool isChecked,
  ) {
    final AppController appController = Get.find();

    return Container(
      height: 160,
      width: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: appController.isDarkModeOn.value
                ? isChecked
                    ? appTheme.gray200
                    : appTheme.black900
                : isChecked
                    ? Color.fromRGBO(237, 245, 237, 1)
                    : appTheme.whiteA700,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.4,
              color: isChecked
                  ? ColorConstants.backgroundColorButtonGreen
                  : appTheme.gray200.withOpacity(.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isChecked
                            ? ColorConstants.backgroundColorButtonGreen
                            : appController.isDarkModeOn.value
                                ? appTheme.gray100
                                : appTheme.gray90099,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: ColorConstants.backgroundColorButtonGreen,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? appTheme.gray100
                            : appTheme.black900,
                        fontSize: 14,
                        fontWeight:
                            isChecked ? FontWeight.w500 : FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    value: isChecked,
                    onChanged: null,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return ColorConstants.backgroundColorButtonGreen;
                        }
                        return appController.isDarkModeOn.value
                            ? Colors.transparent
                            : Colors.white;
                      },
                    ),
                    activeColor: ColorConstants.backgroundColorButtonGreen,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingCard(
    BuildContext context,
    String imageAvatar,
    String userName,
    String contentComment,
  ) {
    final AppController appController = Get.find();

    return Container(
      height: 180,
      width: 320,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: appController.isDarkModeOn.value
            ? appTheme.gray200
            : appTheme.whiteA700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageAvatar,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            contentComment,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
