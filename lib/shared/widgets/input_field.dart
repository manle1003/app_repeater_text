// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:get/get.dart';
import '../../app_controller.dart';
import '../../theme/theme_helper.dart';

class InputField extends StatelessWidget {
  final void Function(String?)? onSaved;

  final String hintText;
  final String? icon;
  final bool obscureText;
  final bool? enableTexfield;
  final bool? isBorder;
  final Color? leadingIconColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final IconButton? iconButton;
  final Widget? suffixIcon;
  final String? initValue;
  final void Function(String)? onChanged;
  final bool digitsOnly;
  final int? maxLength;
  final bool isCheckMaxlenght;
  final double? paddingIcon;
  bool validate = false;
  bool checkBackgroundColorTextfield;
  final String? labelText;
  final bool checkSizeTextField;
  List<TextInputFormatter>? inputFormatters;
  InputField({
    Key? key,
    required this.hintText,
    this.icon,
    this.leadingIconColor,
    this.obscureText = false,
    this.enableTexfield = true,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
    this.focusNode,
    this.isBorder,
    this.validator,
    this.iconButton,
    this.suffixIcon,
    this.initValue,
    this.inputFormatters,
    this.onChanged,
    this.digitsOnly = false,
    this.paddingIcon,
    this.checkBackgroundColorTextfield = false,
    this.checkSizeTextField = false,
    this.labelText,
    this.maxLength,
    this.isCheckMaxlenght = false,
  }) : super(key: key);

  PrimaryColors get appTheme => ThemeHelper().themeColor();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      validator: validator,
      keyboardType: digitsOnly ? TextInputType.number : keyboardType,
      textInputAction: textInputAction,
      cursorColor: ColorConstants.kPrimaryColor,
      controller: controller,
      onSaved: onSaved,
      focusNode: focusNode,
      obscureText: obscureText,
      initialValue: initValue,
      style: TextStyle(
        color: checkBackgroundColorTextfield == true
            ? appController.isDarkModeOn.value
                ? ColorConstants.white
                : ColorConstants.black
            : ColorConstants.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintMaxLines: checkSizeTextField ? 3 : 1,
        contentPadding: EdgeInsets.symmetric(
          vertical: checkSizeTextField ? 100 : 16,
          horizontal: 10,
        ),
        isDense: true,
        labelStyle: TextStyle(
          color: appController.isDarkModeOn.value
              ? ColorConstants.white.withOpacity(.6)
              : Colors.grey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: appController.isDarkModeOn.value
              ? ColorConstants.white.withOpacity(.6)
              : Colors.grey.withOpacity(0.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.6,
            color: appController.isDarkModeOn.value
                ? ColorConstants.white.withOpacity(.6)
                : Colors.grey.withOpacity(0.4),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorConstants.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.4,
            color: ColorConstants.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1.6,
            color: ColorConstants.backgroundColorButtonGreen.withOpacity(.5),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      maxLength: isCheckMaxlenght ? maxLength : null,
      buildCounter: isCheckMaxlenght
          ? (context,
                  {required currentLength, required isFocused, maxLength}) =>
              Text('${currentLength}/$maxLength')
          : null,
    );
  }
}
