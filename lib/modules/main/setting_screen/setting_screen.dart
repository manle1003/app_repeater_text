// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/components/user_profile_setting_groups.dart';
import 'package:flutter_getx_base/modules/main/components/user_profile_setting_item.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../../shared/widgets/show_dialog_upgrade.dart';

class SettingScreen extends GetView<SettingController> {
  final ScanQrCodeController scanQrCodeController =
      Get.put(ScanQrCodeController());
  final TextEditingController _upgradeProController = TextEditingController();
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
