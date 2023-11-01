// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_image_view.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../models/save_item_scan_model.dart';
import '../../../shared/constants/image_constant.dart';
import '../../../shared/widgets/menu_popup_custom.dart';
import '../../../shared/widgets/show_dialog_add_group.dart';

class ScanDetailScreen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final AppController appController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  // final QRCode? qrCodeData = Get.arguments;
  final Map arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final QRCode? qrCodeData = arguments['qrCode'];
    scanQrCodeController.titleChange.value = "QR code scan";
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Detail'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(Routes.QR_CODE),
        ),
        actions: [
          MenuPopupCustom(
            onPressedShare: () {
              if (qrCodeData != null) {
                historyController.exportItemToCsv(qrCodeData);
              }
            },
            onPressedFavorite: () async {
              historyController.saveFavorite(
                await SharedPreferencesManager.instance
                        .getString('idCurrentQRCode') ??
                    '',
              );
            },
            onPressedEdit: () {
              Get.dialog(
                ShowDialogAddGroup(
                  formKey: scanQrCodeController.changeTitleScanDetailFormKey,
                  pressOK: () {
                    scanQrCodeController.changeTitle(
                      qrCodeData?.id ?? '',
                      scanQrCodeController.changeTitleScanDetailFormKey,
                      scanQrCodeController.changeTitleScanDetailController.text,
                    );
                    scanQrCodeController.changeTitleScanDetailController
                        .clear();
                  },
                  textEditingController:
                      scanQrCodeController.changeTitleScanDetailController,
                ),
              );
            },
          )
        ],
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkmodeAppbar
            : ColorConstants.backgroundColorButtonGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => ListTile(
                leading: Container(
                  width: getSize(40),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.text_fields,
                    color: ColorConstants.backgroundColorButtonGreen,
                  ),
                ),
                title: Text(
                  scanQrCodeController.titleChange.value,
                  style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightGray
                          : Colors.black,
                      fontSize: 18),
                ),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy - H:m:s').format(DateTime.now()),
                  style: TextStyle(
                    color: ColorConstants.greyColor,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: appTheme.gray300,
                ),
                color: appController.isDarkModeOn.value
                    ? ColorConstants.grey800
                    : ColorConstants.white,
              ),
              child: Padding(
                padding: getPadding(all: 10),
                child: Text(
                  qrCodeData?.qrCode ?? '',
                  style: CustomTextStyles.labelBlack500Size18Fw500,
                ),
              ),
            ),
            SizedBox(
              height: getSize(26),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomImageView(
                  title: 'Search',
                  svgPath: ImageConstant.icSearch,
                  height: getSize(44),
                  color: ColorConstants.backgroundColorButtonGreen,
                  onTap: () => scanQrCodeController
                      .launchSearch(qrCodeData?.qrCode ?? ''),
                ),
                CustomImageView(
                  title: 'Share',
                  svgPath: ImageConstant.icShare,
                  height: getSize(44),
                  color: ColorConstants.backgroundColorButtonGreen,
                  onTap: () => scanQrCodeController
                      .shareQrCode(qrCodeData?.qrCode ?? ''),
                ),
                CustomImageView(
                  title: 'Copy',
                  svgPath: ImageConstant.icCopy,
                  height: getSize(44),
                  color: ColorConstants.backgroundColorButtonGreen,
                  onTap: () =>
                      scanQrCodeController.copyText(qrCodeData?.qrCode ?? ''),
                ),
              ],
            ),
            SizedBox(
              height: getSize(20),
            ),
            Obx(
              () {
                return scanQrCodeController.nativeAdIsLoaded.value
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 300,
                          minHeight: 10,
                          maxHeight: 310,
                          maxWidth: 450,
                        ),
                        child: AdWidget(ad: scanQrCodeController.nativeAd!),
                      )
                    : CircularProgressIndicator();
              },
            ),
            buildQrCodeOrImage(),
          ],
        ),
      ),
    );
  }

  Widget buildQrCodeOrImage() {
    final String? imagePath = arguments['imagePath'];
    final QRCode? qrCodeData = arguments['qrCode'];
    switch (imagePath) {
      case '':
        return Padding(
          padding: EdgeInsets.all(40),
          child: Container(
            padding: EdgeInsets.all(20),
            color: ColorConstants.white,
            child: Center(
              child: Screenshot(
                controller: scanQrCodeController.screenshotController,
                child: getQrCodeOrBarcodeWidget(qrCodeData),
              ),
            ),
          ),
        );

      default:
        return Padding(
          padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: Image.file(
            File(imagePath ?? ''),
            height: getSize(350),
          ),
        );
    }
  }

  Widget getQrCodeOrBarcodeWidget(QRCode? qrCodeData) {
    if (qrCodeData == null) {
      return Container();
    }

    switch (qrCodeData.type) {
      case "barcode93":
      case "barcode39":
      case "barcode128":
      case "barcode8":
      case "barcode13":
        return BarcodeWidget(
          barcode: Barcode.code93(),
          data: qrCodeData.qrCode,
          width: double.infinity,
          height: 300,
          color: Colors.black,
          drawText: false,
        );
      default:
        return QrImageView(
          data: qrCodeData.qrCode,
          version: QrVersions.auto,
        );
    }
  }
}
