import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class ConfirmDialog extends StatelessWidget {
  final AppController appController = Get.find();
  ConfirmDialog({
    Key? key,
    required this.title,
    this.content,
    this.ok,
  }) : super(key: key);

  final String? title;
  final String? content;
  final Function()? ok;
  BorderRadius roundedBorder16 = BorderRadius.circular(
    getHorizontalSize(
      14,
    ),
  );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Center(
      child: Container(
        height: getSize(150),
        width: getSize(300),
        decoration: BoxDecoration(
          borderRadius: roundedBorder16,
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : appTheme.gray100,
        ),
        child: Column(
          children: [
            Padding(
              padding: getPadding(top: 20, left: 20),
              child: Row(
                children: [
                  Text(
                    ConstantsCommon.delete.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightGray
                          : appTheme.gray200,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(top: 14, left: 20),
              child: Row(
                children: [
                  Text(
                    content ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.backgroundColor
                          : appTheme.gray200,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    ConstantsCommon.cancel.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? appTheme.gray500
                          : appTheme.gray600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: ok,
                  child: Text(
                    ConstantsCommon.ok.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
