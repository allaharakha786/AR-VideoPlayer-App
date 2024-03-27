import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_events.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';
import 'package:videoplayer/helper/utills/alert_dialog.dart';
import 'package:videoplayer/helper/utills/text_styles.dart';

// ignore: must_be_immutable
class OnTapClass extends StatefulWidget {
  String title;
  OnTapClass({super.key, required this.title});

  @override
  State<OnTapClass> createState() => _OnTapClassState();
}

late VideoPlayerBloc bloc;
late String title;

class _OnTapClassState extends State<OnTapClass> {
  @override
  void initState() {
    bloc = BlocProvider.of<VideoPlayerBloc>(context);
    title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        bloc.add(ShowControllerEvent());
      },
      child: Container(
        height: mediaQuerySize.height.h,
        width: mediaQuerySize.width.w,
        color: ColorsResources.BLACK_COLOR_54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: DimensionsResource.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);

                        if (!bloc.state.isPortrait!) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                  Text(
                      title.length <= 20
                          ? title
                          : '${title.substring(0, 20)}...',
                      style: MyTextStyle.videoPlayerScreenStyle(
                          context, ColorsResources.WHITE_COLOR)),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        bloc.add(ShowControllerEvent());

                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialogClass(),
                        );
                      },
                      child: const Icon(Icons.more_horiz)),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: DimensionsResource.PADDING_SIZE_DEFAULT),
                    child: GestureDetector(
                        onTap: () {
                          bloc.add(SkipPreviousEvent());
                        },
                        child: const Icon(Icons.skip_previous_rounded))),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      bloc.state.controller!.value.isPlaying
                          ? bloc.add(PauseVideoEvent())
                          : bloc.add(PlayVideoEvent());
                    },
                    child: Icon(bloc.state.controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      right: DimensionsResource.PADDING_SIZE_DEFAULT),
                  child: GestureDetector(
                      onTap: () {
                        bloc.add(SkipNextEvent());
                      },
                      child: const Icon(Icons.skip_next)),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: mediaQuerySize.width.w,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            DimensionsResource.PADDING_SIZE_DEFAULT),
                        child: Row(
                          children: [
                            Text(
                              formatDuration(
                                  bloc.state.controller!.value.position),
                              style: MyTextStyle.videoPlayerScreenStyle(
                                  context, ColorsResources.WHITE_COLOR),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => Slider(
                                  inactiveColor: ColorsResources.WHITE_COLOR,
                                  thumbColor: ColorsResources.WHITE_COLOR,
                                  activeColor: ColorsResources.RED_COLOR,
                                  value: bloc.state.sliderValue,
                                  min: 0.0,
                                  max: bloc.state.controller!.value.duration
                                      .inSeconds
                                      .toDouble(),
                                  onChanged: (value) {
                                    bloc.add(SliderValueEvent(value: value));
                                    bloc.state.controller!.seekTo(
                                        Duration(seconds: value.toInt()));
                                  }),
                            ),
                            Text(
                                formatDuration(
                                    bloc.state.controller!.value.duration),
                                style: MyTextStyle.videoPlayerScreenStyle(
                                    context, ColorsResources.WHITE_COLOR)),
                            bloc.state.isPortrait!
                                ? IconButton(
                                    onPressed: () {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.landscapeLeft,
                                        DeviceOrientation.landscapeRight
                                      ]);
                                      bloc.add(IsPortraitFalseEvent());
                                    },
                                    icon: const Icon(Icons.screen_rotation))
                                : IconButton(
                                    onPressed: () {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                        DeviceOrientation.portraitDown
                                      ]);
                                      bloc.add(IsPortraitTrueEvent());
                                    },
                                    icon: const Icon(
                                        Icons.screen_rotation_rounded))
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}
