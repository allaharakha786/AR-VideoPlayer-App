import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_events.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_states.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';
import 'package:videoplayer/helper/constants/screen_percentage.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';
import 'package:videoplayer/presentation/screens/widgets/my_slider.dart';
import 'package:videoplayer/presentation/screens/widgets/my_text_button.dart';

class AlertDialogClass extends StatefulWidget {
  const AlertDialogClass({super.key});

  @override
  State<AlertDialogClass> createState() => _AlertDialogClassState();
}

class _AlertDialogClassState extends State<AlertDialogClass> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoPlayerBloc bloc = BlocProvider.of<VideoPlayerBloc>(context);
    Size mediaQuerySize = MediaQuery.of(context).size;
    return BlocBuilder<VideoPlayerBloc, VideoplayerStates>(
        builder: (context, state) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: ColorsResources.BLACK_COLOR_12,
        alignment: Alignment.center,
        elevation: 3,
        insetPadding: const EdgeInsets.only(
            top: DimensionsResource.PADDING_SIZE_LARGE,
            bottom: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_35.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          child: ListView(
            children: [
              FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: mediaQuerySize.height *
                            ScreenPercentage.SCREEN_SIZE_8.h,
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_100.w,
                        child: MySlider(
                          controllerValue: state.brightness,
                          startIcon: CupertinoIcons.light_min,
                          endIcon: CupertinoIcons.light_max,
                          onChange: (value) {
                            bloc.add(SetScreenBrightnessEvent(value: value));
                          },
                        )),
                  ],
                ),
              ),
              const Divider(),
              FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                      child: SizedBox(
                          height: mediaQuerySize.height *
                              ScreenPercentage.SCREEN_SIZE_8.h,
                          width: mediaQuerySize.width *
                              ScreenPercentage.SCREEN_SIZE_100.w,
                          child: MySlider(
                            controllerValue: state.volume,
                            startIcon: CupertinoIcons.volume_down,
                            endIcon: CupertinoIcons.volume_up,
                            onChange: (value) {
                              bloc.add(ChangeVolumeEvent(volume: value));
                            },
                          )),
                    ),
                  ],
                ),
              ),
              const Divider(),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextButton(
                      text: StringResources.SCREEN_ZOOM,
                      color: ColorsResources.WHITE_COLOR,
                    ),
                    CustomTextButton(
                      text: StringResources.ORIGINAL,
                      ontap: () {
                        bloc.add(OriginalZoomEvent());
                      },
                      color: ColorsResources.WHITE_COLOR,
                    ),
                    CustomTextButton(
                        text: StringResources.CROP,
                        ontap: () {
                          bloc.add(CropZoomEvent());
                        },
                        color: ColorsResources.WHITE_COLOR),
                    CustomTextButton(
                        text: StringResources.STRECH,
                        ontap: () {
                          bloc.add(StrechZoomEvent());
                        },
                        color: ColorsResources.WHITE_COLOR),
                  ],
                ),
              ),
              const Divider(),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextButton(
                      text: StringResources.PLAYBACK_SPEED,
                      color: ColorsResources.WHITE_COLOR,
                    ),
                    CustomTextButton(
                        text: StringResources.SPEED_075X,
                        ontap: () {
                          bloc.add(PlayBackSpeedEvent(speed: 0.75));
                        },
                        color: ColorsResources.WHITE_COLOR),
                    CustomTextButton(
                        text: StringResources.NORMAL_SPEED,
                        ontap: () {
                          bloc.add(PlayBackSpeedEvent(speed: 1.0));
                        },
                        color: ColorsResources.WHITE_COLOR),
                    CustomTextButton(
                        text: StringResources.SPEED_125X,
                        ontap: () {
                          bloc.add(PlayBackSpeedEvent(speed: 1.25));
                        },
                        color: ColorsResources.WHITE_COLOR),
                    CustomTextButton(
                        text: StringResources.SPEED_150X,
                        ontap: () {
                          bloc.add(PlayBackSpeedEvent(speed: 1.50));
                        },
                        color: ColorsResources.WHITE_COLOR),
                    CustomTextButton(
                        text: StringResources.SPEED_2X,
                        ontap: () {
                          bloc.add(PlayBackSpeedEvent(speed: 2.0));
                        },
                        color: ColorsResources.WHITE_COLOR),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
