import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/user_profile_setting_item.dart';
import 'package:flutter_getx_base/shared/widgets/custom_text_style.dart';
import 'package:get/get.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../shared/constants/colors.dart';

class BuildSettingsGroup extends StatelessWidget {
  final String? settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final String? settingsGroupContentTitle;
  final TextStyle? settingsGroupContentTitleStyle;
  final List<BuildSettingsItem> items;
  final double? iconItemSize;
  final String? subTitle;

  BuildSettingsGroup(
      {this.settingsGroupTitle,
      this.settingsGroupTitleStyle,
      this.settingsGroupContentTitle,
      this.settingsGroupContentTitleStyle,
      required this.items,
      this.subTitle,
      this.iconItemSize});

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (settingsGroupTitle != null)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    settingsGroupTitle!,
                    style: (settingsGroupTitleStyle == null)
                        ? CustomTextStyles.labelBlack500Size18Fw600
                        : settingsGroupTitleStyle,
                  ),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                if (settingsGroupContentTitle != null)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 24,
                        top: 24,
                        left: 18,
                      ),
                      child: Text(
                        settingsGroupContentTitle!,
                        style: (settingsGroupContentTitleStyle == null)
                            ? CustomTextStyles.labelBlack500Size14Fw500
                            : settingsGroupContentTitleStyle,
                      ),
                    ),
                  ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Divider(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.darkGray.withOpacity(.5)
                            : ColorConstants.black.withOpacity(.15),
                        thickness: 0.5,
                      ),
                    );
                  },
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return items[index];
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: ScrollPhysics(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
