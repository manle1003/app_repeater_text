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

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  final ScanQrCodeController scanQrCodeController = Get.find();
  final AppController appController = Get.find();

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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 28,
              ),
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
                            color: ColorConstants.black,
                          ),
                        ),
                        onPressed: () {
                          scanQrCodeController.openDrawer();
                        },
                      ),
                      Text(
                        ConstantsCommon.home.tr,
                        style: CustomTextStyles.labelBlack500Size24Fw700,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: ColorConstants.black,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Text(
                    'Enter text',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, bottom: 12, top: 2),
                    child: InputField(
                      digitsOnly: true,
                      // controller: scanQrCodeController.phoneController,
                      hintText: ConstantsCommon.phone.tr,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: InputField(
                              digitsOnly: true,
                              // controller: scanQrCodeController.phoneController,
                              hintText: '10',
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
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Repeat Text'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0ac775)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 360,
                    color: Color.fromARGB(255, 226, 226, 226),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
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
                                  itemCount: 100,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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

  // Widget _buildActionButton(
  //     {required IconData icon, required VoidCallback onPressed}) {
  //   return NormalButton(
  //     onPressed: onPressed,
  //     child: Icon(
  //       icon,
  //       size: getSize(28),
  //       color: ColorConstants.white,
  //     ),
  //   );
  // }

//   Widget _buildQrView(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? size.height * 0.4
//         : size.height * 0.4;
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: (QRViewController qrViewController) {
//         controller.onQRViewCreated(qrViewController, context);
//       },
//       overlay: QrScannerOverlayShape(
//         borderColor: ColorConstants.colorDarkModeBlue,
//         borderRadius: 5,
//         borderLength: 20,
//         borderWidth: 10,
//         cutOutSize: scanArea,
//       ),
//       onPermissionSet: (ctrl, p) =>
//           controller.onPermissionSet(context, ctrl, p),
//     );
//   }
}
