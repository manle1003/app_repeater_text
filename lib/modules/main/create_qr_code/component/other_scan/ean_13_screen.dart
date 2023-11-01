// ignore_for_file: deprecated_member_use

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/input_field.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/shared/widgets/show_dialog_add_group.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_base/shared/widgets/custom_icon_button.dart';
import 'package:screenshot/screenshot.dart';

import '../../../components/constants_common.dart';
import '../../../setting_screen/setting_controller.dart';

class Ean13Screen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final String textTitle = Get.arguments;
  final AppController appController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    scanQrCodeController.titleChange.value = textTitle;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            scanQrCodeController.titleChange.value != ""
                ? scanQrCodeController.titleChange.value
                : textTitle,
          ),
          centerTitle: true,
          actions: [
            Obx(
              () => scanQrCodeController.isCheckEan8.value
                  ? MenuPopupCustom(
                      onPressedDelete: () {
                        scanQrCodeController.ean13Controller.clear();
                        scanQrCodeController.isCheckEan13.value = false;
                      },
                      onPressedShare: () {},
                    )
                  : IconButton(
                      onPressed: () =>
                          scanQrCodeController.createBarcodeEAN13(context),
                      icon: Icon(Icons.done, color: Colors.white),
                    ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              scanQrCodeController.ean13Controller.clear();
              Get.back();
              scanQrCodeController.isCheckEan13.value = false;
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: appController.isDarkModeOn.value
              ? Color(0xFF233142)
              : settingController.isCheckColors.value,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: getPadding(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Obx(
                  () => Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstant.ic_barcode,
                        color: ColorConstants.backgroundColorButtonGreen,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        scanQrCodeController.titleChange.value != ""
                            ? scanQrCodeController.titleChange.value
                            : textTitle,
                        style: CustomTextStyles.labelBlack500Size18Fw600,
                      ),
                      Spacer(),
                      scanQrCodeController.isCheckEan13.value
                          ? IconButton(
                              onPressed: () {
                                Get.dialog(
                                  ShowDialogAddGroup(
                                    formKey: scanQrCodeController
                                        .changeTitleEan13FormKey,
                                    pressOK: () {
                                      scanQrCodeController.changeTitle(
                                        scanQrCodeController.idCurrent.value,
                                        scanQrCodeController
                                            .changeTitleEan13FormKey,
                                        scanQrCodeController
                                            .changeTitleEan13Controller.text,
                                      );
                                    },
                                    textEditingController: scanQrCodeController
                                        .changeTitleEan13Controller,
                                  ),
                                );
                                scanQrCodeController.changeTitleEan13Controller
                                    .clear();
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/ic_create_qr.svg',
                                color: ColorConstants.black,
                              ),
                            )
                          : SizedBox.shrink(),
                      scanQrCodeController.isCheckEan13.value
                          ? IconButton(
                              onPressed: () async {
                                historyController.saveFavorite(
                                  await SharedPreferencesManager.instance
                                          .getString('idCurrentQRCode') ??
                                      '',
                                );
                              },
                              icon: Icon(Icons.favorite_border),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getSize(10),
              ),
              Obx(
                () => scanQrCodeController.isCheckEan13.value
                    ? Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: ColorConstants.white,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: getPadding(all: 30),
                                child: Screenshot(
                                  controller:
                                      scanQrCodeController.screenshotController,
                                  child: BarcodeWidget(
                                    barcode:
                                        Barcode.fromType(BarcodeType.CodeEAN13),
                                    data: scanQrCodeController.barcodeData,
                                    width: double.infinity,
                                    height: 300,
                                    color: Colors.black,
                                    drawText: false,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(all: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButtonCustom(
                                  imageUrl: 'assets/svgs/img_save_qr_code.png',
                                  tilte: ConstantsCommon.save.tr,
                                  onPressed: () =>
                                      scanQrCodeController.getImageQrCode(),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                IconButtonCustom(
                                  imageUrl: 'assets/svgs/img_share_qr_code.png',
                                  tilte: ConstantsCommon.share.tr,
                                  onPressed: () =>
                                      scanQrCodeController.shareImageFromPath(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Form(
                        key: scanQrCodeController.ean13FormKey,
                        child: Padding(
                          padding: getPadding(all: 16),
                          child: Column(
                            children: [
                              InputField(
                                controller:
                                    scanQrCodeController.ean13Controller,
                                hintText: 'Enter input',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstantsCommon.codeRequired.tr;
                                  }
                                  if (value.length != 12) {
                                    return ConstantsCommon.code12Character.tr;
                                  }
                                  return null;
                                },
                                isCheckMaxlenght: true,
                                maxLength: 12,
                                digitsOnly: true,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
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
