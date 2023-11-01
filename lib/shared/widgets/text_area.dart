import 'package:flutter/material.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:get/get.dart';
import '../../modules/main/components/constants_common.dart';
import 'card_view.dart';

class TextArea extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();

  final TextEditingController textEditingController;
  final IconData? suffixIcon;
  final Function onSuffixIconPressed;
  final Color? borderColor;
  final double? borderRadius;
  final bool validation;
  final bool digitsOnly;
  final String? errorText;
  final Key? key;

  TextArea({
    this.digitsOnly = false,
    required this.textEditingController,
    this.suffixIcon,
    required this.onSuffixIconPressed,
    required this.borderColor,
    this.borderRadius,
    required this.validation,
    this.errorText,
    this.key,
  });
}

class _BodyState extends State<TextArea> {
  var reasonErrorVisibility = false;
  Color? borderColor;

  @override
  void initState() {
    borderColor = widget.borderColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardView(
          borderRadius: widget.borderRadius,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.4),
                width: 1.6,
              ),
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? 0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ConstantsCommon.enterInput.tr,
                      hintStyle: TextStyle(
                        color: ColorConstants.greyColor.withOpacity(.9),
                      ),
                    ),
                    keyboardType: widget.digitsOnly
                        ? TextInputType.number
                        : TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    minLines: 2,
                    maxLines: 5,
                    controller: widget.textEditingController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.errorText;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      widget.suffixIcon,
                      color: const Color(0xFF0023DB),
                    ),
                    onPressed: () => {widget.onSuffixIconPressed()},
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: Visibility(
            visible: reasonErrorVisibility,
            child: Text(
              widget.errorText == null ? '' : widget.errorText!,
              style: const TextStyle(color: Color(0xFFCA0D0C), fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}
