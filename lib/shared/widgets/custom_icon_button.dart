import 'package:flutter/material.dart';
import 'package:flutter_getx_base/shared/utils/size_utils.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    Key? key,
    required this.imageUrl,
    required this.tilte,
    this.onPressed,
  });

  final String imageUrl;
  final String tilte;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            height: getSize(46),
          ),
          SizedBox(
            height: getSize(8),
          ),
          Text(tilte),
        ],
      ),
    );
  }
}
