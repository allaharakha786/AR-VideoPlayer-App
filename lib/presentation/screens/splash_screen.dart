import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/image_resources.dart';
import 'package:videoplayer/helper/constants/screen_percentage.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';
import 'package:videoplayer/helper/utills/text_styles.dart';
import 'package:videoplayer/presentation/screens/navigation_drawer_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(),
          ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
        width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
        color: ColorsResources.BACKGROUND_COLORS,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                height:
                    mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_20.h,
                width:
                    mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_20.w,
                ImageResources.APP_LOGO),
            Text(
              StringResources.AR_PLAYER,
              style: MyTextStyle.appbarStyle(context),
            )
          ],
        ),
      ),
    );
  }
}
