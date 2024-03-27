import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';

// ignore: must_be_immutable
class CustomTextButton extends StatelessWidget {
  String text;
  Color? color;
  void Function()? ontap;
  CustomTextButton({super.key, required this.text, this.ontap, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: const ButtonStyle(),
        onPressed: ontap,
        child: Text(
          text,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
            color: color,
            fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp,
          )),
        ));
  }
}
