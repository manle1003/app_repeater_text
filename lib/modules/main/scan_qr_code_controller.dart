// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:flutter_getx_base/modules/main/setting_screen/setting_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/common.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_getx_base/shared/widgets/common_widget.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../lang/language.dart';
import '../../lang/translation_service.dart';
import 'components/ads/ad_helper.dart';
import 'history/history_controller.dart';

class ScanQrCodeController extends GetxController {
  DateTime? currentBackPressTime;

  // Create QR Code controller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController myQrCodeController = TextEditingController();
  final TextEditingController temporaryController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController queryController = TextEditingController();
  final TextEditingController fullnameContactController =
      TextEditingController();
  final TextEditingController companyContactController =
      TextEditingController();
  final TextEditingController addressContactController =
      TextEditingController();
  final TextEditingController phoneContactController = TextEditingController();
  final TextEditingController emailContactController = TextEditingController();
  final TextEditingController noteContactController = TextEditingController();
  final TextEditingController webLinkController = TextEditingController();
  final TextEditingController usedEmailController = TextEditingController();
  final TextEditingController topicEmailController = TextEditingController();
  final TextEditingController noteEmailController = TextEditingController();
  final TextEditingController phoneSMSController = TextEditingController();
  final TextEditingController smsController = TextEditingController();
  final TextEditingController usedPhoneController = TextEditingController();

  // Change Title Controller
  final TextEditingController changeTitleTemporaryController =
      TextEditingController();
  final TextEditingController changeTitleWebLinkController =
      TextEditingController();
  final TextEditingController changeTitleContactController =
      TextEditingController();
  final TextEditingController changeTitleEmailController =
      TextEditingController();
  final TextEditingController changeTitleSMSController =
      TextEditingController();
  final TextEditingController changeTitleLocationController =
      TextEditingController();
  final TextEditingController changeTitlePhoneController =
      TextEditingController();
  final TextEditingController changeTitleCalendarController =
      TextEditingController();
  final TextEditingController changeTitleEan8Controller =
      TextEditingController();
  final TextEditingController changeTitleEan13Controller =
      TextEditingController();
  final TextEditingController changeTitleCode39Controller =
      TextEditingController();
  final TextEditingController changeTitleCode93Controller =
      TextEditingController();
  final TextEditingController changeTitleCode128Controller =
      TextEditingController();
  final TextEditingController changeTitleScanDetailController =
      TextEditingController();
  final TextEditingController changeTitleMyQrCodeController =
      TextEditingController();

  // Create QR Code Form Key
  final myQRCodeKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> changeTitleMyQrCodeFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleTemporaryFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleWebLinkFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleContactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleSMSFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleLocationFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitlePhoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleCalendarFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleEan8FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleEan13FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleCode39FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleCode93FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleCode128FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changeTitleScanDetailFormKey =
      GlobalKey<FormState>();

  final GlobalKey<FormState> createTextFieldFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> temporaryFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> webLinkFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> smsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  // Create Other QR Code Form Key
  final GlobalKey<FormState> ean8FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> ean13FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> code39FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> code93FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> code128FormKey = GlobalKey<FormState>();

  // Create QR Code controller
  final TextEditingController ean8Controller = TextEditingController();
  final TextEditingController ean13Controller = TextEditingController();
  final TextEditingController code39Controller = TextEditingController();
  final TextEditingController code93Controller = TextEditingController();
  final TextEditingController code128Controller = TextEditingController();

  QRViewController? controllerQRcodeView;
  late TabController tabController;
  final HistoryController historyController = Get.put(HistoryController());

  final RxBool isFlashOn = false.obs;
  RxBool hasScanned = false.obs;
  final isFrontCamera = true.obs;
  RxBool reasonValidation = true.obs;
  RxBool isCheckTemporary = false.obs;
  RxBool isCheckWebLink = false.obs;
  RxBool isCheckContact = false.obs;
  RxBool isCheckEmail = false.obs;
  RxBool isCheckSms = false.obs;
  RxBool isCheckLocation = false.obs;
  RxBool isCheckPhone = false.obs;
  RxBool isCheckCalandar = false.obs;
  RxBool isCheckEan8 = false.obs;
  RxBool isCheckEan13 = false.obs;
  RxBool isCheckCode39 = false.obs;
  RxBool isCheckCode93 = false.obs;
  RxBool isCheckCode128 = false.obs;
  RxBool isPressed = false.obs;

  XFile? pickedImage;
  XFile? imageFile;
  String scannedText = "";
  RxString titleMyQrCode = "My QR".obs;
  RxString titleChange = "".obs;
  RxString titleMyQRCodeChange = "".obs;
  RxString titleScanChange = "Scan QR".obs;
  RxString idCurrent = "".obs;
  RxString idMyQRCode = "".obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String myQRcode = "";
  String barcodeData = "";
  String barcodeEan8Data = "";

  List<QRCode> listQRCode = [];
  Rx<QRCode?> getDataMyQRCode = Rx<QRCode?>(null);

//Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  final SettingController settingController = Get.put(SettingController());

  List<IconData> iconList = [
    Icons.text_fields,
    Icons.link,
    Icons.person,
    Icons.mail,
    Icons.sms,
    Icons.location_on,
    Icons.phone,
    // Icons.calendar_month,
    Icons.qr_code,
  ];

  BannerAd? bannerAd;
  final RxBool isBannerAdLoaded = false.obs;
  NativeAd? nativeAd;
  final RxBool nativeAdIsLoaded = false.obs;

  @override
  void onReady() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          nativeAdIsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    )..load();
    super.onReady();
  }

  @override
  void onInit() async {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        print("Ad Failed to Load");
        ad.dispose();
      }, onAdLoaded: (ad) {
        print("Ad Loaded");
        isBannerAdLoaded.value = true;
      }),
      request: const AdRequest(),
    );
    bannerAd?.load();
    loadFromSharedPreferences();
    isCheckMyQRCodePress();
    settingController.getColor();
    super.onInit();
  }

  void isCheckMyQRCodePress() async {
    String idMyQRCode = await ischeckMyQRCode();
    idMyQRCode.isNotEmpty ? isPressed.value = true : isPressed.value = false;
  }

  var _selectedLanguage = Language(1, "🇺🇸", "English", "en").obs;

  Future<void> loadFromSharedPreferences() async {
    idMyQRCode.value =
        await SharedPreferencesManager.instance.getString('idMyQRCode') ?? "";
  }

  Future<void> shareQrCode(String qrCode) async {
    Share.share(qrCode);
  }

  Future<void> copyText(String qrCodeData) async {
    Clipboard.setData(
      ClipboardData(
        text: qrCodeData,
      ),
    );
    Get.snackbar(
      'Copy!',
      'Copy success!',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(milliseconds: 700),
    );
  }

  Future<void> launchSearch(String searchText) async {
    final Uri _url = Uri.parse(
        'https://www.google.com/search?q=${Uri.encodeComponent(searchText)}');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> deleteQr() async {
    SharedPreferencesManager.instance.deleteQRCodeById(idMyQRCode.value);
    myQrCodeController.clear();
    SharedPreferencesManager.instance.clear('idMyQRCode');
    getDataMyQRCode.value = null;
    isPressed.value = false;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime ?? DateTime.now()) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;
      CommonWidget.toast(CommonConstants.tittleExitApp.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> saveNetworkImage(String imagePath) async {
    try {
      bool? success = await GallerySaver.saveImage(imagePath);

      if (success != null && success) {
        Get.snackbar('Success!', 'Image is saved!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(milliseconds: 900));
      } else {
        Get.snackbar('Success!', 'Failed to save image!',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(milliseconds: 900));
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> getImage(ImageSource source, BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        if (imageFile != null) {
          String? str = await Scan.parse(imageFile?.path ?? '');
          if (str != null) {
            if (str != null && str.isNotEmpty) {
              isScanning = true;

              var uuid = Uuid();
              idCurrent.value = uuid.v4();
              SharedPreferencesManager.instance
                  .setString('idCurrentQRCode', idCurrent.value);
              final QRCode qrCode = QRCode(
                id: idCurrent.value,
                qrCode: str,
                title: titleScanChange.value,
                favorite: false,
                type: 'qrcodescan',
                dateTime: DateTime.now(),
              );
              saveSharePreference(qrCode);

              Get.offAllNamed(Routes.SCAN_DETAIL_SCREEN, arguments: {
                'qrCode': qrCode,
                'imagePath': imageFile?.path,
              })?.then(
                (_) {
                  isScanning = false;
                },
              );
            }
          }
        }
      }
    } catch (e) {
      imageFile = null;
      scannedText = 'Error occurred while scanning'.tr;
    }
  }

  Future<String> ischeckMyQRCode() async {
    String myQRcode = '';
    String getMyQRCode =
        await SharedPreferencesManager.instance.getString('idMyQRCode') ?? '';

    if (getMyQRCode != '' && getMyQRCode != null) {
      listQRCode.clear();
      listQRCode = await SharedPreferencesManager.instance.getQRCodeList();
      for (var e in listQRCode) {
        if (e.id == getMyQRCode) {
          myQRcode = e.id;
          getDataMyQRCode.value = e;
          return myQRcode;
        }
      }
    }
    return myQRcode;
  }

  void toggleCamera() {
    isFrontCamera.value = !isFrontCamera.value;
    controllerQRcodeView?.flipCamera();
  }

  // Create and Change Title My QR Code
  void createMyQrCode(BuildContext context) async {
    if (createTextFieldFormKey.currentState!.validate()) {
      isPressed.value = true;
      String fullName = fullNameController.text;
      String company = companyController.text;
      String address = addressController.text;
      String phone = phoneController.text;
      String email = emailController.text;
      String note = noteController.text;

      myQRcode = "$fullName\n$company\n$address\n$phone\n$email\n$note";

      // SharedPreferencesManager.instance.setBool('isPressed', isPressed.value);

      var uuid = Uuid();

      idMyQRCode.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idMyQRCode', idMyQRCode.value);

      final QRCode qrCode = QRCode(
        id: idMyQRCode.value,
        qrCode: myQRcode,
        title: titleMyQrCode.value,
        favorite: false,
        isPress: isCheckTemporary.value,
        type: 'myqrcode',
        dateTime: DateTime.now(),
      );

      getDataMyQRCode?.value = qrCode;

      saveSharePreference(qrCode);
    }
  }

  void changeTitleMyQrCode() async {
    if (changeTitleMyQrCodeFormKey.currentState!.validate()) {
      titleMyQrCode.value = myQrCodeController.text;
      await SharedPreferencesManager.instance
          .updateTitleForQRCode(idCurrent.value, titleMyQrCode.value);
      myQrCodeController.clear();
      Get.back();
    }
  }

  // Create and Change Title Temporary
  void createTemporaryQrCode(BuildContext context) async {
    if (temporaryFormkey.currentState!.validate()) {
      isCheckTemporary.value = true;
      String temporary = temporaryController.text;

      myQRcode = temporary;
      var uuid = Uuid();

      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        isPress: isCheckTemporary.value,
        type: 'text',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Web Link
  void createWebLinkQrCode(BuildContext context) async {
    if (webLinkFormKey.currentState!.validate()) {
      isCheckWebLink.value = true;
      String webLink = webLinkController.text;

      myQRcode = webLink;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        isPress: isCheckWebLink.value,
        type: 'weblink',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Location
  void createLocationQrCode(BuildContext context) async {
    if (locationFormKey.currentState!.validate()) {
      isCheckLocation.value = true;
      String latitude = latitudeController.text;
      String longitude = latitudeController.text;
      String query = latitudeController.text;

      myQRcode = "$latitude\n$longitude\n$query";

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        type: 'location',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Contact
  void createContactQrCode(BuildContext context) async {
    if (contactFormKey.currentState!.validate()) {
      isCheckContact.value = true;
      String fullnameContact = fullnameContactController.text;
      String companyContact = companyContactController.text;
      String addressContact = addressContactController.text;
      String phoneContact = phoneContactController.text;
      String emailContact = emailContactController.text;
      String noteContact = noteContactController.text;

      myQRcode =
          "$fullnameContact\n$companyContact\n$addressContact\n$phoneContact\n$emailContact\n$noteContact";

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        type: 'contact',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Email
  void createEmailQrCode(BuildContext context) async {
    if (emailFormKey.currentState!.validate()) {
      isCheckEmail.value = true;

      String email = usedEmailController.text;
      String topicEmail = topicEmailController.text;
      String noteEmail = noteEmailController.text;

      myQRcode = "$email\n$topicEmail\n$noteEmail";

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        type: 'email',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create SMS
  void createSMSQrCode(BuildContext context) async {
    if (smsFormKey.currentState!.validate()) {
      isCheckSms.value = true;
      String phoneSMS = phoneSMSController.text;
      String sms = smsController.text;

      myQRcode = "$phoneSMS\n$sms";

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: titleChange.value,
        title: 'SMS',
        favorite: false,
        type: 'sms',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Phone
  void createPhoneQrCode(BuildContext context) async {
    if (phoneFormKey.currentState!.validate()) {
      isCheckPhone.value = true;
      String usedPhone = usedPhoneController.text;

      myQRcode = usedPhone;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: myQRcode,
        title: titleChange.value,
        favorite: false,
        type: 'phone',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Barcode EAN8
  void createBarcodeEAN8(BuildContext context) async {
    if (ean8FormKey.currentState!.validate()) {
      isCheckEan8.value = true;
      String ean8 = ean8Controller.text;

      barcodeEan8Data = ean8;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: barcodeEan8Data,
        title: titleChange.value,
        favorite: false,
        type: 'barcode8',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Barcode EAN13
  void createBarcodeEAN13(BuildContext context) async {
    if (ean13FormKey.currentState!.validate()) {
      isCheckEan13.value = true;
      String ean13 = ean13Controller.text;

      barcodeData = ean13;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: barcodeData,
        title: titleChange.value,
        favorite: false,
        type: 'barcode8barcode8',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Barcode CODE39
  void createBarcodeCode39(BuildContext context) async {
    if (code39FormKey.currentState!.validate()) {
      isCheckCode39.value = true;
      String code39 = code39Controller.text;

      barcodeData = code39;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: barcodeData,
        title: titleChange.value,
        favorite: false,
        type: 'barcode39',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Barcode CODE93
  void createBarcodeCode93(BuildContext context) async {
    if (code93FormKey.currentState!.validate()) {
      isCheckCode93.value = true;
      String code93 = code93Controller.text;

      barcodeData = code93;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: barcodeData,
        title: titleChange.value,
        favorite: false,
        type: 'barcode93',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  // Create Barcode CODE128
  void createBarcodeCode128(BuildContext context) async {
    if (code128FormKey.currentState!.validate()) {
      isCheckCode128.value = true;
      String code128 = code128Controller.text;

      barcodeData = code128;

      var uuid = Uuid();
      idCurrent.value = uuid.v4();
      SharedPreferencesManager.instance
          .setString('idCurrentQRCode', idCurrent.value);

      final QRCode qrCode = QRCode(
        id: idCurrent.value,
        qrCode: barcodeData,
        title: titleChange.value,
        favorite: false,
        type: 'barcode128',
        dateTime: DateTime.now(),
      );

      saveSharePreference(qrCode);
    }
  }

  bool isScanning = false;
  void onQRViewCreated(
      QRViewController qrViewController, BuildContext context) {
    controllerQRcodeView = qrViewController;
    qrViewController.scannedDataStream.listen(
      (scanData) async {
        if (!isScanning) {
          String qrCodeData = scanData.code ?? "";
          if (qrCodeData != null && qrCodeData.isNotEmpty) {
            isScanning = true;

            var uuid = Uuid();
            idCurrent.value = uuid.v4();
            SharedPreferencesManager.instance
                .setString('idCurrentQRCode', idCurrent.value);
            final QRCode qrCode = QRCode(
              id: idCurrent.value,
              qrCode: qrCodeData,
              title: titleScanChange.value,
              favorite: false,
              type: 'qrcodescan',
              dateTime: DateTime.now(),
            );
            saveSharePreference(qrCode);

            Get.offAllNamed(Routes.SCAN_DETAIL_SCREEN, arguments: {
              'qrCode': qrCode,
              'imagePath': '',
            })?.then(
              (_) {
                isScanning = false;
              },
            );
          }
        }
      },
    );
  }

  Language get selectedLanguage => _selectedLanguage.value;

  void handleLanguageSelection(Language? language) {
    if (language != null) {
      _selectedLanguage.value = language;
      String code = language.code;

      if (code == 'vi') {
        TranslationService.changeLocale('vi');
      } else if (code == 'en') {
        TranslationService.changeLocale('en');
      } else if (code == 'ko') {
        TranslationService.changeLocale('ko');
      }
      print("Bạn đã chọn: ${language.name}");
    }
  }

  void toggleFlashLight() {
    isFlashOn.toggle();
    final qrController = controllerQRcodeView;
    if (qrController != null) {
      qrController.toggleFlash();
    }
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      CommonWidget.toast(CommonConstants.noPermission.tr);
    }
  }

  void changeTitle(String idCurrent, GlobalKey<FormState> changeTitleFormKey,
      String title) async {
    if (changeTitleFormKey.currentState!.validate()) {
      await SharedPreferencesManager.instance
          .updateTitleForQRCode(idCurrent, title);
      titleChange.value = title;
      changeTitleTemporaryController.clear();
      isCheckMyQRCodePress();
      Get.back();
    }
  }

  void getImageQrCode() async {
    try {
      Uint8List? image = await screenshotController.capture();

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        await saveNetworkImage(imagePath.path);
      } else {
        print("Failed to capture the screenshot.");
      }
    } catch (error) {
      print(error);
    }
  }

  void shareImageFromPath() async {
    try {
      Uint8List? image = await screenshotController.capture();

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = File('${directory.path}/image.jpg');
        await imagePath.writeAsBytes(image);

        if (await imagePath.exists()) {
          await Share.shareFiles([imagePath.path]);
        } else {
          print("Image file does not exist.");
        }
      } else {
        print("Failed to capture the screenshot.");
      }
    } catch (error) {
      print("Error sharing image: $error");
    }
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }

  void saveSharePreference(QRCode qrCode) async {
    listQRCode.clear();
    listQRCode = await SharedPreferencesManager.instance.getQRCodeList();
    listQRCode.add(qrCode);
    SharedPreferencesManager.instance.saveQRCodeList(listQRCode);
  }

  @override
  void onClose() {
    super.dispose();
  }
}
