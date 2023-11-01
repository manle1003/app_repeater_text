// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/routes.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../setting_screen/setting_controller.dart';

class CreateQrCodeScreen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();

  final AppController appController = Get.find();
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    List<String> textList = [
      ConstantsCommon.text.tr,
      ConstantsCommon.webLink.tr,
      ConstantsCommon.contact.tr,
      ConstantsCommon.email.tr,
      ConstantsCommon.sms.tr,
      ConstantsCommon.location.tr,
      ConstantsCommon.phone.tr,
      // "Calendar",
      ConstantsCommon.myQR.tr,
    ];

    List<String> barcodeList = [
      ConstantsCommon.ean8.tr,
      ConstantsCommon.ean13.tr,
      ConstantsCommon.code39.tr,
      ConstantsCommon.code93.tr,
      ConstantsCommon.code128.tr,
    ];

    List<String> routesNameCreate = [
      Routes.TEMPORARY_SCREEN,
      Routes.WEB_LINK,
      Routes.CONTACT_SCREEN,
      Routes.EMAIL_SCREEN,
      Routes.SMS_SCREEN,
      Routes.LOCATION_SCREEN,
      Routes.PHONE_SCREEN,
      // Routes.LOCATION_SCREEN,
      Routes.MY_QR_CODE_SCREEN,
    ];

    List<String> routesNameOther = [
      Routes.EAN8_SCREEN,
      Routes.EAN13_SCREEN,
      Routes.CODE39_SCREEN,
      Routes.CODE93_SCREEN,
      Routes.CODE128_SCREEN,
    ];

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text(
              ConstantsCommon.createQRCode.tr,
            ),
            centerTitle: true,
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          drawer: DrawerBarScreen(),
          body: SingleChildScrollView(
            child: Padding(
              padding: getPadding(all: 12),
              child: Column(
                children: [
                  Padding(
                    padding: getPadding(all: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ConstantsCommon.createQRCode.tr,
                        style: CustomTextStyles.labelGray600Size16Fw500,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.darkCard
                          : ColorConstants.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: scanQrCodeController.iconList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            scanQrCodeController.iconList[index],
                            color: settingController.isCheckColors.value,
                          ),
                          title: Text(textList[index]),
                          onTap: () {
                            Get.toNamed(
                              routesNameCreate[index],
                              arguments: textList[index],
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 1.2,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: getPadding(all: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ConstantsCommon.otherTypes.tr,
                        style: CustomTextStyles.labelGray600Size16Fw500,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.darkCard
                          : ColorConstants.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: routesNameOther.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SvgPicture.asset(
                            ImageConstant.ic_barcode,
                            color: settingController.isCheckColors.value,
                          ),
                          title: Text(barcodeList[index]),
                          onTap: () {
                            Get.toNamed(
                              routesNameOther[index],
                              arguments: barcodeList[index],
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 1.2,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
