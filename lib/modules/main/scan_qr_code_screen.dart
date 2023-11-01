// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../shared/utils/size_utils.dart';
import '../../../shared/widgets/normal_button.dart';
import 'components/constants_common.dart';

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  final ScanQrCodeController scanQrCodeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return controller.onWillPop();
      },
      child: Scaffold(
        key: scanQrCodeController.scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: DrawerBarScreen(),
        ),
        body: Stack(
          children: [
            _buildQrView(context),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28, horizontal: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
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
                      Text(
                        ConstantsCommon.scanQRCode.tr,
                        style: CustomTextStyles.labelWhite500Size24Fw400,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.switch_camera,
                          color: ColorConstants.white,
                        ),
                        onPressed: () {
                          controller.toggleCamera();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: getPadding(all: 10),
                    child: Row(
                      children: [
                        _buildActionButton(
                          icon: controller.isFlashOn.value
                              ? Icons.flash_on
                              : Icons.flash_off,
                          onPressed: () => controller.toggleFlashLight(),
                        ),
                        SizedBox(
                          width: getSize(20),
                        ),
                        _buildActionButton(
                          icon: CupertinoIcons.photo_fill_on_rectangle_fill,
                          onPressed: () =>
                              controller.getImage(ImageSource.gallery, context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: controller.isBannerAdLoaded.value
                      ? Container(
                          child: AdWidget(ad: controller.bannerAd!),
                          width: double.infinity,
                          height: 80,
                          alignment: Alignment.center,
                        )
                      : SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return NormalButton(
      onPressed: onPressed,
      child: Icon(
        icon,
        size: getSize(28),
        color: ColorConstants.white,
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? size.height * 0.4
        : size.height * 0.4;
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController qrViewController) {
        controller.onQRViewCreated(qrViewController, context);
      },
      overlay: QrScannerOverlayShape(
        borderColor: ColorConstants.colorDarkModeBlue,
        borderRadius: 5,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) =>
          controller.onPermissionSet(context, ctrl, p),
    );
  }
}
