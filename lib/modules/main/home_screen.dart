// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/home_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../app_controller.dart';
import '../../shared/widgets/input_field.dart';
import 'components/constants_common.dart';
import 'setting_screen/setting_controller.dart';

class HomeScreen extends GetView<HomeController> {
  final AppController appController = Get.find();
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: controller.scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: DrawerBarScreen(),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Transform.scale(
              scale: 0.7,
              child: SvgPicture.asset(
                'assets/icons/ic_menu_vip.svg',
                color: ColorConstants.white,
              ),
            ),
            onPressed: () {
              controller.openDrawer();
            },
          ),
          centerTitle: true,
          title: Text(
            ConstantsCommon.home.tr,
            style: CustomTextStyles.labelWhite700Size18Fw600,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: ColorConstants.white,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: ColorConstants.backgroundColorButtonGreen,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
            () => Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter text',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                InputField(
                  hintText: ConstantsCommon.typeContent.tr,
                  suffixIcon: IconButton(
                    onPressed: controller.clearText,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                  controller: controller.fieldText,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InputField(
                        hintText: '',
                        keyboardType: TextInputType.number,
                        controller: controller.countText,
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: appTheme.gray400,
                              ),
                              child: Checkbox.adaptive(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                value: controller.isChecked.value,
                                onChanged: (bool? value) {
                                  controller.isChecked.value = value!;
                                },
                                activeColor:
                                    ColorConstants.backgroundColorButtonGreen,
                                checkColor: ColorConstants.backgroundColor,
                              ),
                            ),
                            Text('Repeat in new line')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    controller.viewListRepeat();
                  },
                  child: Text('Repeat text'),
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.backgroundColorButtonGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: controller.isChecked.value
                            ? Scrollbar(
                                child: ListView.builder(
                                  itemExtent: 30,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  itemCount: controller.listItems.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(
                                      () => ListTile(
                                        title: Text(
                                          controller.listItems[index],
                                          style: controller.styleFont.value ==
                                                  ''
                                              ? CustomTextStyles
                                                  .labelBlack500Size16Fw500
                                              : GoogleFonts.getFont(
                                                  controller.styleFont.value,
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Scrollbar(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        controller.textRow.value,
                                        style: controller.styleFont.value == ''
                                            ? CustomTextStyles
                                                .labelBlack500Size16Fw500
                                            : GoogleFonts.getFont(
                                                controller.styleFont.value,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                String concatenatedText =
                                    controller.listItems.join(" ");
                                if (concatenatedText.isNotEmpty) {
                                  controller.copyText(concatenatedText);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0ac775),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Copy',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                String concatenatedText =
                                    controller.listItems.join(" ");
                                if (concatenatedText.isNotEmpty)
                                  Share.share(concatenatedText);
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0ac775),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                if (controller.listItems.length != 0) {
                                  Get.toNamed(
                                    Routes.STYLIZE_SCREEN,
                                    arguments: controller.listItems[0],
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0ac775),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.brush_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Stylize',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
