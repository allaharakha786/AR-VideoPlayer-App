import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';

class MyTextStyle {
  static TextStyle appbarStyle(BuildContext context) {
    return GoogleFonts.aDLaMDisplay(
        textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: ColorsResources.ORANGE_COLOR,
            fontSize: DimensionsResource.FONT_SIZE_3X_EXTRA_MEDIUM.sp));
  }

  static TextStyle videosTitleStyle(BuildContext context) {
    return GoogleFonts.roboto(
        textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: ColorsResources.BLACK_COLOR,
            fontWeight: FontWeight.w400,
            fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp));
  }

  static TextStyle videoPlayerScreenStyle(BuildContext context, Color? color) {
    return GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp));
  }
}
