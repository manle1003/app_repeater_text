import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager._privateConstructor();

  static final SharedPreferencesManager instance =
      SharedPreferencesManager._privateConstructor();

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> clear(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> saveQRCodeFavoriteList(List<QRCode> qrCodeFavoriteList) async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesFavoriteJson =
        qrCodeFavoriteList.map((qrCode) => qrCode.toJson()).toList();
    await prefs.setString(
        'qrCodeFavoriteList', json.encode(qrCodesFavoriteJson));
  }

  Future<void> saveQRCodeList(List<QRCode> qrCodes) async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = qrCodes.map((qrCode) => qrCode.toJson()).toList();
    await prefs.setString('qrCodeList', json.encode(qrCodesJson));
  }

  Future<List<QRCode>> getQRCodeList() async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      return decoded.map((json) => QRCode.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> updateTitleForQRCode(String id, String newTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      final List<QRCode> qrCodes =
          decoded.map((json) => QRCode.fromJson(json)).toList();

      final index = qrCodes.indexWhere((qrCode) => qrCode.id == id);

      if (index != -1) {
        qrCodes[index].title = newTitle;

        final updatedQRCodeList =
            qrCodes.map((qrCode) => qrCode.toJson()).toList();
        await prefs.setString('qrCodeList', json.encode(updatedQRCodeList));
      }
    }
  }

  Future<void> changeFavouriteById(
      String idQRCode, bool isCheckFavourite) async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      final List<QRCode> qrCodes =
          decoded.map((json) => QRCode.fromJson(json)).toList();

      final index = qrCodes.indexWhere((qrCode) => qrCode.id == idQRCode);

      if (index != -1) {
        qrCodes[index].favorite = isCheckFavourite;

        final updatedQRCodeList =
            qrCodes.map((qrCode) => qrCode.toJson()).toList();
        await prefs.setString('qrCodeList', json.encode(updatedQRCodeList));
      }
    }
  }

  Future<void> deleteQRCodeById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      List<QRCode> qrCodes =
          decoded.map((json) => QRCode.fromJson(json)).toList();

      final index = qrCodes.indexWhere((qrCode) => qrCode.id == id);

      if (index != -1) {
        qrCodes.removeAt(index);

        final updatedQRCodeList =
            qrCodes.map((qrCode) => qrCode.toJson()).toList();
        await prefs.setString('qrCodeList', json.encode(updatedQRCodeList));
      }
    }
  }

  Future<void> deleteQRCodeAll() async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      List<QRCode> qrCodes =
          decoded.map((json) => QRCode.fromJson(json)).toList();

      qrCodes.clear();

      final updatedQRCodeList =
          qrCodes.map((qrCode) => qrCode.toJson()).toList();
      await prefs.setString('qrCodeList', json.encode(updatedQRCodeList));
    }
  }

  Future<void> deleteAllFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodesJson = prefs.getString('qrCodeList');

    if (qrCodesJson != null) {
      final List<dynamic> decoded = json.decode(qrCodesJson);
      final List<QRCode> qrCodes =
          decoded.map((json) => QRCode.fromJson(json)).toList();

      for (var item in qrCodes) {
        item.favorite = false;
      }

      final updatedQRCodeList =
          qrCodes.map((qrCode) => qrCode.toJson()).toList();
      await prefs.setString('qrCodeList', json.encode(updatedQRCodeList));
    }
  }

  Future<void> saveColorToPreferences(String key, Color color) async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = color.value;
    await prefs.setInt(key, colorValue);
  }

  Future<Color> loadColorFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(key);
    final color = Color(colorValue ?? Colors.transparent.value);
    return color;
  }

  Future<int> getIndexChangeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt('indexChangeLanguage') ?? 0;

    return index;
  }

  Future<void> setLocalTitleChangeLanguage(String localTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final localTitleChange = localTitle;
    await prefs.setString('localTitle', localTitleChange);
  }

  Future<String> getLocalTitleChangeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String localTitle = prefs.getString('localTitle') ?? 'English';

    return localTitle;
  }

  Future<void> setIndexChangeLanguage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final indexChangeLanguage = index;
    await prefs.setInt('indexChangeLanguage', indexChangeLanguage);
  }
}
