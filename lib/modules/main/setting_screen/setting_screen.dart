// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<SettingController> {

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.QR_CODE);
          return true;
        },
        child: Scaffold(
          key: controller.scaffoldSettingKey,
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            backgroundColor: controller.isCheckColors.value,
            title: Text(
              ConstantsCommon.termsOfUse.tr,
              style: TextStyle(color: ColorConstants.white),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                controller.openDrawer();
              },
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class boxThemeColorCustom extends StatelessWidget {
  boxThemeColorCustom({
    super.key,
    required this.colors,
    required this.isCheck,
  });

  final Color colors;
  final bool isCheck;

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.check,
          color: isCheck ? ColorConstants.white : Colors.transparent,
        ),
      ),
    );
  }
}
