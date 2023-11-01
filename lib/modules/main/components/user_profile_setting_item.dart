// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_getx_base/modules/main/components/icon_style.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:flutter_getx_base/shared/constants/image_constant.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../app_controller.dart';
import '../../../../../../lang/translation_service.dart';
import '../../../../../../theme/theme_helper.dart';
import '../../../shared/utils/size_utils.dart';

class BuildSettingsItem extends StatelessWidget {
  final String? imageAsset;
  final IconStyle? iconStyle;
  final Widget? widgetTitle;
  final Widget? subWidget1;
  final Widget? subWidget2;
  final Widget? subWidget3;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool? isShowTrailing;
  final bool? isDisableColor;
  final bool? isDeleteColor;
  final bool? isIconLanguage;
  final Function()? onLongPress;

  final AppController appController = Get.find();
  PrimaryColors get appTheme => ThemeHelper().themeColor();

  BuildSettingsItem({
    this.imageAsset,
    this.iconStyle,
    this.widgetTitle,
    this.subWidget1,
    this.subWidget2,
    this.subWidget3,
    this.backgroundColor,
    this.trailing,
    this.isShowTrailing,
    this.isDisableColor = false,
    this.leading,
    this.onTap,
    this.isDeleteColor = false,
    this.isIconLanguage = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListTile(
        onLongPress: onLongPress,
        dense: true,
        onTap: onTap,
        leading: leading != null
            ? leading
            : (iconStyle != null && iconStyle!.withBackground!)
                ? Container(
                    decoration: BoxDecoration(
                      color: iconStyle!.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(iconStyle!.borderRadius!),
                    ),
                    padding: EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      imageAsset ?? ImageConstant.iconAboutUs,
                      width: 12,
                      height: 12,
                      color: iconStyle!.iconsColor,
                    ),
                  )
                : imageAsset != null
                    ? SvgPicture.asset(
                        imageAsset ?? ImageConstant.iconAboutUs,
                        color: isDeleteColor == false
                            ? isDisableColor == false
                                ? appController.isDarkModeOn.value
                                    ? ColorConstants.white.withOpacity(.5)
                                    : ColorConstants.grey800
                                : null
                            : appTheme.red300,
                      )
                    : null,
        title: (widgetTitle != null) ? widgetTitle : null,
        subtitle: (subWidget1 != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  subWidget1 ?? SizedBox(),
                  if (subWidget2 != null)
                    SizedBox(
                      height: 8,
                    ),
                  if (subWidget2 != null) subWidget2 ?? SizedBox(),
                  if (subWidget3 != null)
                    SizedBox(
                      height: 8,
                    ),
                  if (subWidget3 != null) subWidget3 ?? SizedBox(),
                ],
              )
            : null,
        trailing: (trailing != null)
            ? trailing
            : (isShowTrailing == false)
                ? null
                : isIconLanguage == false
                    ? SvgPicture.asset(
                        ImageConstant.iconArrowRight,
                        color: appController.isDarkModeOn.value
                            ? appTheme.whiteA700
                            : appTheme.gray600,
                        width: (24),
                        height: (24),
                      )
                    : SizedBox(
                        width: getSize(45),
                        height: getSize(45),
                        child: Card(
                          color: ColorConstants.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 3.0,
                          child: SpeedDial(
                            icon: Icons.language,
                            direction: SpeedDialDirection.up,
                            curve: Curves.bounceOut,
                            animatedIconTheme: const IconThemeData(size: 12.0),
                            backgroundColor: ColorConstants.primaryColor,
                            foregroundColor: ColorConstants.white,
                            children: _buildLanguageOptions(),
                          ),
                        ),
                      ),
      ),
    );
  }

  List<SpeedDialChild> _buildLanguageOptions() {
    return [
      _buildLanguageOption('🇺🇸 English', 'en'),
      _buildLanguageOption('🇻🇳 Vietnamese', 'vi'),
    ];
  }

  SpeedDialChild _buildLanguageOption(String label, String locale) {
    return SpeedDialChild(
      backgroundColor: ColorConstants.primaryColor,
      label: label,
      onTap: () {
        TranslationService.changeLocale(locale);
      },
    );
  }
}
