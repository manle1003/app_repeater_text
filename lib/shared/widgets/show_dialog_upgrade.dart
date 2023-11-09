// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/routes/routes.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:get/get.dart';

import '../../modules/main/setting_screen/setting_controller.dart';
import '../utils/size_utils.dart';

class ShowDialogUpgrade extends StatefulWidget {
  ShowDialogUpgrade({
    Key? key,
    required this.codeController,
    required this.constGrey,
    required this.hiddenTextField,
    this.contentRemovePro,
  }) : super(key: key);

  final TextEditingController codeController;
  final Color constGrey;
  final bool hiddenTextField;
  final String? contentRemovePro;

  @override
  State<ShowDialogUpgrade> createState() => _ShowDialogUpgradeState();
}

class _ShowDialogUpgradeState extends State<ShowDialogUpgrade> {
  final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
  final AppController appController = Get.find();
  final SettingController settingController = Get.find();

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: codeFormKey,
        child: Center(
          child: Container(
            width: getSize(328),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(16)),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: getPadding(all: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        widget.hiddenTextField
                            ? Text('Promote code'.tr,
                                style:
                                    CustomTextStyles.labelBlack500Size16Fw500)
                            : Text(
                                ' You are Pro version! Do you want to become Free version?'
                                    .tr,
                                style: CustomTextStyles.labelGray400Size14Fw400,
                                textAlign: TextAlign.center,
                              ),
                        SizedBox(height: getSize(16)),
                        widget.hiddenTextField
                            ? Center(
                                child: TextFormField(
                                  controller: widget.codeController,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: appController.isDarkModeOn.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    labelStyle:
                                        TextStyle(color: widget.constGrey),
                                    hintText: 'enterCode'.tr,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: widget.constGrey.withOpacity(.5),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: appTheme.red300,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: appTheme.red300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: ColorConstants
                                            .backgroundColorButtonGreen
                                            .withOpacity(.5),
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'codeIsRequired'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            widget.hiddenTextField
                                ? const SizedBox.shrink()
                                : Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        widget.codeController.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Material(
                                        borderRadius: BorderRadius.circular(8),
                                        color: appController.isDarkModeOn.value
                                            ? Color.fromARGB(255, 19, 36, 56)
                                            : appTheme.gray600,
                                        child: Container(
                                          child: Text(
                                            'Cancel'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: appTheme.gray100,
                                              fontSize: 14,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  if (codeFormKey.currentState!.validate()) {
                                    if (widget.hiddenTextField == true) {
                                      if (widget.codeController.text
                                              .toLowerCase() ==
                                          'nineplus@2023') {
                                        settingController.saveRemoveAds(true);
                                        widget.codeController.clear();
                                        Get.offAllNamed(Routes.SETTING_SCREEN);
                                      } else {
                                        settingController.saveRemoveAds(false);
                                        widget.codeController.clear();
                                      }
                                    } else {
                                      settingController.saveRemoveAds(false);
                                      widget.codeController.clear();
                                      Get.back();
                                    }
                                  }
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  color: appController.isDarkModeOn.value
                                      ? Color.fromARGB(255, 19, 36, 56)
                                      : ColorConstants
                                          .backgroundColorButtonGreen,
                                  child: Container(
                                    child: Text(
                                      'OK'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: appTheme.gray100,
                                        fontSize: 14,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                widget.hiddenTextField
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            widget.codeController.clear();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: appTheme.gray600,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
