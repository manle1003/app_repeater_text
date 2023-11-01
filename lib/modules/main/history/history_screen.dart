import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app_controller.dart';
import 'package:flutter_getx_base/modules/main/components/constants_common.dart';
import 'package:flutter_getx_base/modules/main/components/drawer.dart';
import 'package:flutter_getx_base/modules/main/history/history_controller.dart';
import 'package:flutter_getx_base/modules/main/scan_qr_code_controller.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/constants.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:flutter_getx_base/shared/widgets/dialog_confirm.dart';
import 'package:flutter_getx_base/shared/widgets/menu_popup_custom.dart';
import 'package:flutter_getx_base/theme/theme_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/widgets/show_dialog_add_group.dart';
import '../setting_screen/setting_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  HistoryScreen({super.key});
  final AppController appController = Get.find();
  final ScanQrCodeController scanQrCodeController = Get.find();
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.QR_CODE);
        return true;
      },
      child: Obx(
        () => Scaffold(
          drawer: DrawerBarScreen(),
          appBar: AppBar(
            title: Text(ConstantsCommon.history.tr),
            centerTitle: true,
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
                          controller.deleteQRCodeAll();
                          Get.back();
                        },
                      );
                    },
                  );
                },
                onPressedShare: () {
                  if (controller.listHistory.value != null) {
                    controller.exportAllItemToCsv(controller.listHistory.value);
                  }
                },
              ),
            ],
            backgroundColor: appController.isDarkModeOn.value
                ? Color(0xFF233142)
                : settingController.isCheckColors.value,
          ),
          body: controller.listHistory.value != null &&
                  controller.listHistory.value?.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ConstantsCommon.listHistory.tr,
                              style: CustomTextStyles.labelBlack500Size16Fw500,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                controller.listHistory.value?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final reversedIndex =
                                  controller.listHistory.value!.length -
                                      1 -
                                      index;
                              final item =
                                  controller.listHistory.value?[reversedIndex];
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
                                                controller.deleteQRCodeById(
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
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorConstants
                                          .backgroundColorButtonGreen,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: appTheme.whiteA700,
                                      ),
                                      onPressed: () {
                                        controller.saveFavorite(item?.id ?? '');
                                        slidableKey.currentState?.close();
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
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.SCAN_DETAIL_SCREEN,
                                          arguments: {
                                            'qrCode': item,
                                            'imagePath': '',
                                          },
                                        );
                                      },
                                      leading: Container(
                                        width: getSize(40),
                                        alignment: Alignment.center,
                                        child: controller
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
                                            controller.formatDateTimeNow(
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
                                                  controller.deleteQRCodeById(
                                                      item?.id ?? '');
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                        onPressedShare: () {
                                          if (item != null) {
                                            controller.exportItemToCsv(item);
                                          }
                                        },
                                        onPressedEdit: () {
                                          Get.dialog(
                                            ShowDialogAddGroup(
                                              formKey: controller
                                                  .changeTitleListHistoryFormKey,
                                              pressOK: () {
                                                controller.changeTitle(
                                                  item?.id ?? '',
                                                  controller
                                                      .changeTitleListHistoryFormKey,
                                                  controller
                                                      .changeTitleHistoryController
                                                      .text,
                                                );
                                              },
                                              textEditingController: controller
                                                  .changeTitleHistoryController,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ConstantsCommon.noData.tr,
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
