// ignore_for_file: deprecated_member_use, unused_element, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_icon_button.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/input_field.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/shared/widgets/show_dialog_add_group.dart';
import 'package:flutter_getx_base/shared/widgets/text_area.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../routes/app_pages.dart';
import '../components/drawer.dart';

class MyQrCodeScreen extends StatelessWidget {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final AppController appController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          key: scanQrCodeController.myQRCodeKey,
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            title: Text(ConstantsCommon.myQRCode.tr),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                scanQrCodeController.titleChange.value = "";
                scanQrCodeController.myQRCodeKey.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            actions: [
              Obx(
                () => scanQrCodeController.isPressed.value
                    ? MenuPopupCustom(
                        onPressedDelete: () {
                          scanQrCodeController.deleteQr();
                        },
                        onPressedShare: () {},
                        // onPressedEdit: () {},
                      )
                    : IconButton(
                        onPressed: () =>
                            scanQrCodeController.createMyQrCode(context),
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
                        Icon(Icons.person_3_outlined),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          scanQrCodeController.titleChange.value =
                              scanQrCodeController
                                      .getDataMyQRCode.value?.title ??
                                  ConstantsCommon.myQR.tr,
                          style: CustomTextStyles.labelBlack500Size18Fw600,
                        ),
                        Spacer(),
                        scanQrCodeController.isPressed.value
                            ? IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    ShowDialogAddGroup(
                                      formKey: scanQrCodeController
                                          .changeTitleMyQrCodeFormKey,
                                      pressOK: () {
                                        scanQrCodeController.changeTitle(
                                          scanQrCodeController.idMyQRCode.value,
                                          scanQrCodeController
                                              .changeTitleMyQrCodeFormKey,
                                          scanQrCodeController
                                              .changeTitleMyQrCodeController
                                              .text,
                                        );
                                      },
                                      textEditingController:
                                          scanQrCodeController
                                              .changeTitleMyQrCodeController,
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/ic_create_qr.svg',
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.lightGray
                                      : ColorConstants.black,
                                ),
                              )
                            : SizedBox.shrink(),
                        scanQrCodeController.isPressed.value
                            ? IconButton(
                                onPressed: () async {
                                  historyController.saveFavorite(
                                      await SharedPreferencesManager.instance
                                              .getString('idMyQRCode') ??
                                          '');
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.lightGray
                                      : ColorConstants.black,
                                ),
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
                  () => scanQrCodeController.isPressed.value
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
                                    controller: scanQrCodeController
                                        .screenshotController,
                                    child: QrImageView(
                                      data: scanQrCodeController
                                              .getDataMyQRCode.value?.qrCode ??
                                          '',
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
                                    imageUrl:
                                        'assets/svgs/img_save_qr_code.png',
                                    tilte: ConstantsCommon.save.tr,
                                    onPressed: () =>
                                        scanQrCodeController.getImageQrCode(),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  IconButtonCustom(
                                    imageUrl:
                                        'assets/svgs/img_share_qr_code.png',
                                    tilte: ConstantsCommon.share.tr,
                                    onPressed: () => scanQrCodeController,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: getPadding(all: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  scanQrCodeController
                                          .getDataMyQRCode.value?.qrCode ??
                                      '',
                                  style:
                                      CustomTextStyles.labelGray600Size16Fw600,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Form(
                          key: scanQrCodeController.createTextFieldFormKey,
                          child: Padding(
                            padding: getPadding(all: 16),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Text(
                                        ConstantsCommon.createYourQR.tr,
                                        style: CustomTextStyles
                                            .labelGray600Size16Fw500,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                InputField(
                                  controller:
                                      scanQrCodeController.fullNameController,
                                  hintText: ConstantsCommon.fullName.tr,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ConstantsCommon
                                          .fullNameRequired.tr;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                InputField(
                                  controller:
                                      scanQrCodeController.companyController,
                                  hintText: ConstantsCommon.company.tr,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                InputField(
                                  controller:
                                      scanQrCodeController.addressController,
                                  hintText: ConstantsCommon.Address.tr,
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                InputField(
                                  digitsOnly: true,
                                  controller:
                                      scanQrCodeController.phoneController,
                                  hintText: ConstantsCommon.phone.tr,
                                  suffixIcon: IconButton(
                                    onPressed: () => scanQrCodeController
                                        .createMyQrCode(context),
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
                                    controller:
                                        scanQrCodeController.emailController,
                                    hintText: ConstantsCommon.email.tr),
                                SizedBox(
                                  height: 12,
                                ),
                                TextArea(
                                  borderRadius: 12,
                                  borderColor:
                                      ColorConstants.grey800?.withOpacity(.3),
                                  textEditingController:
                                      scanQrCodeController.noteController,
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
      ),
    );
  }
}
