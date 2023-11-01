import 'package:flutter/material.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';

class MenuPopupCustom extends StatelessWidget {
  MenuPopupCustom({
    Key? key,
    this.onPressedDelete,
    this.onPressedShare,
    this.onPressedSave,
    this.onPressedEdit,
    this.offset,
    this.onPressedFavorite,
  }) : super(key: key);

  final Function()? onPressedDelete;
  final Function()? onPressedShare;
  final Function()? onPressedSave;
  final Function()? onPressedEdit;
  final Function()? onPressedFavorite;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem> items = [];

    if (onPressedDelete != null) {
      items.add(
          popUpMenuItem('assets/icons/delete.png', onPressedDelete ?? () {}));
    }

    if (onPressedShare != null) {
      items.add(popUpMenuItem('assets/icons/csv.png', onPressedShare ?? () {}));
    }

    if (onPressedSave != null) {
      items.add(popUpMenuItem('assets/icons/csv.png', onPressedSave ?? () {}));
    }

    if (onPressedEdit != null) {
      items.add(
          popUpMenuItem('assets/icons/ic_edit_qr.png', onPressedEdit ?? () {}));
    }

    if (onPressedFavorite != null) {
      items.add(popUpMenuItem(
          'assets/icons/love.png', onPressedFavorite ?? () {}));
    }

    return PopupMenuButton(
      offset: offset != null ? offset! : Offset(-30, 40),
      constraints: BoxConstraints.tightFor(width: getSize(58)),
      itemBuilder: (context) => items,
    );
  }

  PopupMenuItem<dynamic> popUpMenuItem(String icons, Function() onPressed) {
    return PopupMenuItem(
      onTap: onPressed,
      child: Center(
        child: Image.asset(
          icons,
          height: getSize(34),
        ),
      ),
    );
  }
}
