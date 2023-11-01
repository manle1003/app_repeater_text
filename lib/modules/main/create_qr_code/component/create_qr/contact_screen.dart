// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/widgets/custom_icon_button.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/input_field.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/shared/widgets/show_dialog_add_group.dart';
import 'package:flutter_getx_base/shared/widgets/text_area.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../setting_screen/setting_controller.dart';

class ContactScreen extends StatelessWidget {
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
              () => scanQrCodeController.isCheckContact.value
                  ? MenuPopupCustom(
                      onPressedDelete: () {
                        scanQrCodeController.fullnameContactController.clear();
                        scanQrCodeController.companyContactController.clear();
                        scanQrCodeController.addressContactController.clear();
                        scanQrCodeController.phoneContactController.clear();
                        scanQrCodeController.emailContactController.clear();
                        scanQrCodeController.noteContactController.clear();
                        scanQrCodeController.isCheckContact.value = false;
                      },
                      onPressedShare: () {},
                    )
                  : IconButton(
                      onPressed: () =>
                          scanQrCodeController.createContactQrCode(context),
                      icon: Icon(Icons.done, color: Colors.white),
                    ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              scanQrCodeController.fullnameContactController.clear();
              scanQrCodeController.companyContactController.clear();
              scanQrCodeController.addressContactController.clear();
              scanQrCodeController.phoneContactController.clear();
              scanQrCodeController.emailContactController.clear();
              scanQrCodeController.noteContactController.clear();
              Get.back();
              scanQrCodeController.isCheckContact.value = false;
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
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Icon(Icons.person_3_outlined),
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
                      scanQrCodeController.isCheckContact.value
                          ? IconButton(
                              onPressed: () {
                                Get.dialog(
                                  ShowDialogAddGroup(
                                    formKey: scanQrCodeController
                                        .changeTitleContactFormKey,
                                    pressOK: () {
                                      scanQrCodeController.changeTitle(
                                        scanQrCodeController.idCurrent.value,
                                        scanQrCodeController
                                            .changeTitleContactFormKey,
                                        scanQrCodeController
                                            .changeTitleContactController.text,
                                      );
                                    },
                                    textEditingController: scanQrCodeController
                                        .changeTitleContactController,
                                  ),
                                );
                                scanQrCodeController
                                    .changeTitleContactController
                                    .clear();
                              },
                              icon: SvgPicture.asset(
                                'assets/icons/ic_create_qr.svg',
                                color: ColorConstants.black,
                              ),
                            )
                          : SizedBox.shrink(),
                      scanQrCodeController.isCheckContact.value
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
              SizedBox(
                height: getSize(10),
              ),
              Obx(
                () => scanQrCodeController.isCheckContact.value
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
                        key: scanQrCodeController.contactFormKey,
                        child: Padding(
                          padding: getPadding(all: 16),
                          child: Column(
                            children: [
                              InputField(
                                controller: scanQrCodeController
                                    .fullnameContactController,
                                hintText: ConstantsCommon.fullName.tr,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ConstantsCommon.fullNameRequired.tr;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              InputField(
                                  controller: scanQrCodeController
                                      .companyContactController,
                                  hintText: ConstantsCommon.company.tr),
                              SizedBox(
                                height: 12,
                              ),
                              InputField(
                                  controller: scanQrCodeController
                                      .addressContactController,
                                  hintText: ConstantsCommon.Address.tr),
                              SizedBox(
                                height: 12,
                              ),
                              InputField(
                                digitsOnly: true,
                                controller:
                                    scanQrCodeController.phoneContactController,
                                hintText: ConstantsCommon.phone.tr,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.person_3,
                                    color: appController.isDarkModeOn.value
                                        ? ColorConstants
                                            .backgroundColorButtonGreen
                                        : ColorConstants
                                            .backgroundColorButtonGreen,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              InputField(
                                  controller: scanQrCodeController
                                      .emailContactController,
                                  hintText: ConstantsCommon.email.tr),
                              SizedBox(
                                height: 12,
                              ),
                              TextArea(
                                borderRadius: 12,
                                borderColor:
                                    ColorConstants.grey800?.withOpacity(.3),
                                textEditingController:
                                    scanQrCodeController.noteContactController,
                                onSuffixIconPressed: () => {},
                                validation: true,
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
