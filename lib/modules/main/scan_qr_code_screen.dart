// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../app_controller.dart';
import '../../shared/widgets/input_field.dart';
import 'components/constants_common.dart';
import 'setting_screen/setting_controller.dart';

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final AppController appController = Get.find();
  final SettingController settingController = Get.find();

  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scanQrCodeController.scaffoldKey,
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
              scanQrCodeController.openDrawer();
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
          child: Column(
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
                  onPressed: clearText,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
                controller: fieldText,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: InputField(
                        initValue: '10',
                        hintText: '',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (newValue) {},
                        ),
                        Text('Repeat in new line')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text('Repeat text'),
                style: ElevatedButton.styleFrom(
                  primary: appController.isDarkModeOn.value
                      ? Color(0xFF233142)
                      : settingController.isCheckColors
                          .value, // Set the button's background color
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
                color: Color.fromARGB(255, 226, 226, 226),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0ac775),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                    ), // Set border radius here
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.copy),
                                      SizedBox(width: 8),
                                      Text('Copy'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
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
                                      Icon(Icons.share),
                                      SizedBox(width: 8),
                                      Text('Share'),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
