// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/widgets/custom_icon_button.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/shared/widgets/show_dialog_add_group.dart';
import 'package:flutter_getx_base/shared/widgets/text_area.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../scan_qr_code_controller.dart';

class TemporaryScreen extends StatelessWidget {
  final String textTitle = Get.arguments;

  final AppController appController = Get.find();
  final ScanQrCodeController scanQrCodeController = Get.find();
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
          leading: IconButton(
            onPressed: () {
              scanQrCodeController.titleChange.value = "";
              scanQrCodeController.temporaryController.clear();
              Get.back();
              scanQrCodeController.isCheckTemporary.value = false;
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            Obx(
              () => scanQrCodeController.isCheckTemporary.value
                  ? MenuPopupCustom(
                      onPressedDelete: () {
                        scanQrCodeController.temporaryController.clear();
                        scanQrCodeController.isCheckTemporary.value = false;
                      },
                      onPressedShare: () {},
                    )
                  : IconButton(
                      onPressed: () =>
                          scanQrCodeController.createTemporaryQrCode(context),
                      icon: Icon(Icons.done, color: Colors.white),
                    ),
            ),
          ],
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
                      Icon(Icons.text_fields),
                      SizedBox(
                        width: 4,
                      ),
                      Obx(
                        () => Text(
                          scanQrCodeController.titleChange.value != ""
                              ? scanQrCodeController.titleChange.value
                              : textTitle,
                          style: CustomTextStyles.labelBlack500Size18Fw600,
                        ),
                      ),
                      Spacer(),
                      scanQrCodeController.isCheckTemporary.value
                          ? IconButton(
                              onPressed: () {
                                Get.dialog(
                                  ShowDialogAddGroup(
                                    formKey: scanQrCodeController
                                        .changeTitleTemporaryFormKey,
                                    pressOK: () {
                                      scanQrCodeController.changeTitle(
                                        scanQrCodeController.idCurrent.value,
                                        scanQrCodeController
                                            .changeTitleTemporaryFormKey,
                                        scanQrCodeController
                                            .changeTitleTemporaryController
                                            .text,
                                      );
                                    },
                                    textEditingController: scanQrCodeController
                                        .changeTitleTemporaryController,
                                  ),
                                );
                                scanQrCodeController
                                    .changeTitleTemporaryController
                                    .clear();
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/ic_create_qr.svg',
                                color: ColorConstants.black,
                              ),
                            )
                          : SizedBox.shrink(),
                      scanQrCodeController.isCheckTemporary.value
                          ? IconButton(
                              onPressed: () async {
                                historyController.saveFavorite(
                                    await SharedPreferencesManager.instance
                                            .getString('idCurrentQRCode') ??
                                        '');
                              },
                              icon: Icon(Icons.favorite_border),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              Obx(
                () => scanQrCodeController.isCheckTemporary.value
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
                                  child: QrImageView(
                                    data: scanQrCodeController.myQRcode,
                                    version: QrVersions.auto,
                                    size: getSize(320),
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
                        key: scanQrCodeController.temporaryFormkey,
                        child: Padding(
                          padding: getPadding(all: 20),
                          child: TextArea(
                            borderRadius: 12,
                            borderColor:
                                ColorConstants.grey800?.withOpacity(.3),
                            textEditingController:
                                scanQrCodeController.temporaryController,
                            onSuffixIconPressed: () => {},
                            validation:
                                scanQrCodeController.reasonValidation.value,
                            errorText: ConstantsCommon.required.tr,
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
