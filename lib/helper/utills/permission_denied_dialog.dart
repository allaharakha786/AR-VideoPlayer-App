import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';
import 'package:videoplayer/helper/constants/screen_percentage.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';
import 'package:videoplayer/helper/utills/text_styles.dart';
import 'package:videoplayer/presentation/screens/widgets/my_text_button.dart';

class PermissionDeniedDialog extends StatelessWidget {
  const PermissionDeniedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(DimensionsResource.RADIUS_SMALL)),
      ),
      backgroundColor: ColorsResources.BACKGROUND_COLORS,
      alignment: Alignment.center,
      elevation: 3,
      insetPadding: const EdgeInsets.only(
          top: DimensionsResource.PADDING_SIZE_LARGE,
          bottom: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_27.h,
        width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_60.w,
        child: Padding(
          padding: const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
          child: Column(
            children: [
              Text(
                StringResources.PERMISSION_DENIED,
                style: MyTextStyle.videoPlayerScreenStyle(
                    context, ColorsResources.BLACK_COLOR),
              ),
              Divider(
                color: ColorsResources.ORANGE_COLOR,
              ),
              Text(
                StringResources.PERMISSION_DENIED_CONTENT,
                style: MyTextStyle.videoPlayerScreenStyle(
                    context, ColorsResources.BLACK_COLOR),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  text: StringResources.OPEN_SETTING,
                  ontap: openAppSettings,
                  color: ColorsResources.BLACK_COLOR,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
