// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoryController extends GetxController {
  final listHistory = Rxn<List<QRCode>>();
  final TextEditingController changeTitleHistoryController =
      TextEditingController();
  final GlobalKey<FormState> changeTitleListHistoryFormKey =
      GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getSharePreference();
  }

  Future<void> exportItemToCsv(QRCode item) async {
    final List<List<dynamic>> rows = [
      ['Title', 'Date', 'QR Code'], // Remove the extra comma after 'Title'
      [item.title, formatDateTimeNow(item.dateTime), item.qrCode],
    ];

    final String csv = const ListToCsvConverter().convert(rows);

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${item.id}.csv');

    await file.writeAsString(csv);

    await Share.shareFiles([file.path]);
  }

  Future<void> exportAllItemToCsv(List<QRCode>? items) async {
    if (items == null || items.isEmpty) {
      return;
    }

    final StringBuffer csvContent = StringBuffer();

    csvContent.writeln('QR Code');

    for (var item in items) {
      csvContent.writeln(item.qrCode);
    }

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/qr_codes.csv');

    await file.writeAsString(csvContent.toString());
    await Share.shareFiles([file.path], text: 'Sharing QR Codes CSV file');
  }

  void getSharePreference() async {
    listHistory.value = await SharedPreferencesManager.instance.getQRCodeList();
  }

  void deleteQRCodeById(String id) {
    SharedPreferencesManager.instance.deleteQRCodeById(id);
    getSharePreference();
  }

  void changeTitle(
      String id, GlobalKey<FormState> changeTitleFormKey, String title) async {
    if (changeTitleListHistoryFormKey.currentState!.validate()) {
      await SharedPreferencesManager.instance.updateTitleForQRCode(id, title);
      getSharePreference();
      Get.back();
      changeTitleHistoryController.clear();
    }
  }

  void deleteQRCodeAll() {
    SharedPreferencesManager.instance.deleteQRCodeAll();
    getSharePreference();
  }

  String formatDateTimeNow(DateTime dateTime) {
    final formattedDate = DateFormat('dd/MM/yyyy - H:m:s').format(dateTime);
    return formattedDate;
  }

  void saveFavorite(String id) {
    SharedPreferencesManager.instance.changeFavouriteById(id, true);
    Get.snackbar('Success', 'Add success',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(milliseconds: 900));
  }

  Widget setIcon(String typeIcon) {
    switch (typeIcon) {
      case 'text':
        return Icon(
          Icons.text_fields,
          color: ColorConstants.backgroundColorButtonGreen,
        );
      case 'weblink':
        return Icon(
          Icons.text_fields,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'contact':
        return Icon(
          Icons.person,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'email':
        return Icon(
          Icons.email,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'sms':
        return Icon(
          Icons.sms,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'location':
        return Icon(
          Icons.location_on,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'phone':
        return Icon(
          Icons.phone,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'calendar':
        return Icon(
          Icons.calendar_month,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      case 'myqrcode':
        return Icon(
          Icons.qr_code,
          color: ColorConstants.backgroundColorButtonGreen,
        );
      case 'qrcodescan':
        return Icon(
          Icons.qr_code,
          color: ColorConstants.backgroundColorButtonGreen,
        );

      default:
        return SvgPicture.asset(
          ImageConstant.ic_barcode,
          color: ColorConstants.backgroundColorButtonGreen,
        );
    }
  }
}
