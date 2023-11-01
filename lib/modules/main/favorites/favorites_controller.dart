import 'package:flutter/material.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:flutter_getx_base/shared/sharepreference/sharepreference.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final listData = Rxn<List<QRCode>>();
  final listFavorite = Rxn<List<QRCode>>();
  final TextEditingController changeTitleFavoriteController =
      TextEditingController();
  final GlobalKey<FormState> changeTitleListFavoriteFormKey =
      GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    getSharePreference();
  }

  Future<void> getSharePreference() async {
    listData.value = await SharedPreferencesManager.instance.getQRCodeList();
    if (listData.value != null && listData.value?.length != 0) {
      getListFavorite();
    }
  }

  Future<void> getListFavorite() async {
    if (listData.value != null && listData.value!.isNotEmpty) {
      listFavorite.value = [];
      for (var item in listData.value!) {
        if (item.favorite == true) {
          listFavorite.value?.add(item);
        }
      }
    }
  }

  void getListFavoriteData() {
    if (listData.value != null && listData.value?.length != 0) {
      getListFavorite();
    }
  }

  void changeTitle(
      String id, GlobalKey<FormState> changeTitleFormKey, String title) async {
    if (changeTitleListFavoriteFormKey.currentState!.validate()) {
      await SharedPreferencesManager.instance.updateTitleForQRCode(id, title);
      getSharePreference();
      Get.back();
      changeTitleFavoriteController.clear();
    }
  }

  void removeFavourite(String id) {
    SharedPreferencesManager.instance.changeFavouriteById(id, false);
    Get.snackbar(
      'Success!',
      'Removed favorite success!',
      snackPosition: SnackPosition.BOTTOM,
    );
    getSharePreference();
  }

  void deleteAllFavourite() {
    SharedPreferencesManager.instance.deleteAllFavourite();
    getSharePreference();
  }
}
