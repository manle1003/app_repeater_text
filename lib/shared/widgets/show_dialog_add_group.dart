// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/input_field.dart';
import 'package:get/get.dart';

class ShowDialogAddGroup extends StatelessWidget {
  ShowDialogAddGroup({
    Key? key,
    required this.formKey,
    required this.pressOK,
    required this.textEditingController,
  }) : super(key: key);

  final ScanQrCodeController scanQrCodeController = Get.find();
  final GlobalKey<FormState> formKey;
  final AppController appController = Get.find();
  final Function() pressOK;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: Center(
          child: Container(
            width: getSize(328),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(16)),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: getPadding(all: 14),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Name QR'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: getSize(16)),
                    InputField(
                      controller: textEditingController,
                      hintText: 'My QR',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: getSize(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: ColorConstants.darkGray,
                              ),
                            )),
                        SizedBox(
                          width: getSize(10),
                        ),
                        TextButton(
                          onPressed: pressOK,
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color:
                                    ColorConstants.backgroundColorButtonGreen),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
