import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_getx_base/routes/app_pages.dart';
import 'package:flutter_getx_base/shared/constants/colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () async {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColorButtonGreen,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Lottie.asset("assets/svgs/img_splash_top.json",
              width: 120, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
