// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/models/save_item_scan_model.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/favorites/favorites_controller.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/widgets/dialog_confirm.dart';
import '../../../shared/widgets/show_dialog_add_group.dart';
import '../components/drawer.dart';
import '../setting_screen/setting_controller.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  FavoriteScreen({super.key});

  final AppController appController = Get.find();
  final ScanQrCodeController scanQrCodeController = Get.find();
  final HistoryController historyController = Get.put(HistoryController());
  final List<QRCode> listQRCode = [];
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getListFavoriteData();
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(ConstantsCommon.favourites.tr),
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
            actions: [
              MenuPopupCustom(
                onPressedDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmDialog(
                        title: ConstantsCommon.delete.tr,
                        content: ConstantsCommon.doWantDeleteAll.tr,
                        ok: () {
                          controller.deleteAllFavourite();
                          Get.back();
                        },
                      );
                    },
                  );
                },
                onPressedShare: () {
                  if (controller.listFavorite.value != null) {
                    historyController
                        .exportAllItemToCsv(controller.listFavorite.value);
                  }
                },
              ),
            ],
          ),
          body: controller.listFavorite.value != null &&
                  controller.listFavorite.value?.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ConstantsCommon.listFavorite.tr,
                              style: CustomTextStyles.labelBlack500Size16Fw500,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                controller.listFavorite.value?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final reversedIndex =
                                  controller.listFavorite.value!.length -
                                      1 -
                                      index;
                              final item =
                                  controller.listFavorite.value?[reversedIndex];
                              final slidableKey = GlobalKey<SlidableState>();

                              return Slidable(
                                key: slidableKey,
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorConstants.red,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: appTheme.gray300,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ConfirmDialog(
                                              title: ConstantsCommon.delete.tr,
                                              content: ConstantsCommon
                                                  .doWantDelete.tr,
                                              ok: () {
                                                controller.removeFavourite(
                                                    item?.id ?? '');
                                                slidableKey.currentState
                                                    ?.close();
                                                Get.back();
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                                child: Padding(
                                  padding: getPadding(all: 1.2),
                                  child: Container(
                                    padding: getPadding(top: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: appController.isDarkModeOn.value
                                          ? ColorConstants.darkCard
                                          : ColorConstants.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      onTap: () => Get.toNamed(
                                        Routes.SCAN_DETAIL_SCREEN,
                                        arguments: {
                                          'qrCode': item,
                                          'imagePath': '',
                                        },
                                      ),
                                      leading: Container(
                                        width: getSize(40),
                                        alignment: Alignment.center,
                                        child: historyController
                                            .setIcon(item?.type ?? ''),
                                      ),
                                      title: Text(
                                        item?.title ?? '',
                                        style: TextStyle(
                                            color:
                                                appController.isDarkModeOn.value
                                                    ? ColorConstants.lightGray
                                                    : Colors.black,
                                            fontSize: 18),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: getSize(8),
                                          ),
                                          Text(
                                            historyController.formatDateTimeNow(
                                              item?.dateTime ?? DateTime.now(),
                                            ),
                                            style: TextStyle(
                                              color: ColorConstants.greyColor,
                                            ),
                                          ),
                                          Text(
                                            item?.qrCode ?? '',
                                            maxLines: 4,
                                            style: TextStyle(
                                              color: ColorConstants.greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: MenuPopupCustom(
                                        offset: Offset(8, 40),
                                        onPressedDelete: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ConfirmDialog(
                                                title:
                                                    ConstantsCommon.delete.tr,
                                                content: ConstantsCommon
                                                    .doWantDelete.tr,
                                                ok: () {
                                                  controller.removeFavourite(
                                                      item?.id ?? '');
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        onPressedShare: () {
                                          if (item != null) {
                                            historyController
                                                .exportItemToCsv(item);
                                          }
                                        },
                                        onPressedEdit: () {
                                          Get.dialog(
                                            ShowDialogAddGroup(
                                              formKey: controller
                                                  .changeTitleListFavoriteFormKey,
                                              pressOK: () {
                                                controller.changeTitle(
                                                  item?.id ?? '',
                                                  controller
                                                      .changeTitleListFavoriteFormKey,
                                                  controller
                                                      .changeTitleFavoriteController
                                                      .text,
                                                );
                                              },
                                              textEditingController: controller
                                                  .changeTitleFavoriteController,
                                            ),
                                          );
                                          controller
                                              .changeTitleFavoriteController
                                              .clear();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ConstantsCommon.noData.tr,
                        maxLines: 4,
                        style: CustomTextStyles.labelGray600Size16Fw500),
                    Lottie.asset(
                      'assets/svgs/image_no_data.json',
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
