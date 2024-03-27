import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_events.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_states.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:videoplayer/helper/enums/status_enums.dart';
import 'package:videoplayer/helper/utills/on_tap.dart';
import 'package:videoplayer/presentation/screens/widgets/my_toast.dart';

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  String path;

  VideoPlayerScreen({super.key, required this.path});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  double scale = 1.0;
  double prevousScale = 1.0;
  late String title;
  late VideoPlayerBloc bloc;
  @override
  void initState() {
    title = widget.path.split('/').last;
    videoPlayerController = VideoPlayerController.file(File(widget.path));
    videoPlayerController.initialize().then((value) {});
    videoPlayerController.play();
    bloc = BlocProvider.of<VideoPlayerBloc>(context);
    bloc.add(IntializationEvent(controller: videoPlayerController));
    bloc.add(GetScreenBrightnessEvent());
    addListner();

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  addListner() {
    videoPlayerController.addListener(() {
      double newValue =
          videoPlayerController.value.position.inSeconds.toDouble();
      bloc.add(AddListnerEvent(value: newValue));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
        body: BlocListener<VideoPlayerBloc, VideoplayerStates>(
      listener: (context, state) {
        if (state.state == StatusEnum.ERROR_STATE) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(StringResources.ERROR_OCCOURED)));
        }
      },
      child: BlocBuilder<VideoPlayerBloc, VideoplayerStates>(
          builder: (context, state) {
        return GestureDetector(
          onTap: () {
            bloc.add(ShowControllerEvent());
          },
          child: Container(
            color: ColorsResources.BLACK_COLOR,
            height: mediaQuerySize.height.h,
            width: mediaQuerySize.width.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: mediaQuerySize.height.h,
                  width: mediaQuerySize.width.w,
                  child: GestureDetector(
                      onScaleStart: (ScaleStartDetails details) {
                        prevousScale = scale;
                      },
                      onScaleUpdate: (ScaleUpdateDetails details) {
                        bloc.add(ScaleEvent(
                            detailsScale: details.scale,
                            previousScale: prevousScale));
                      },
                      onLongPressStart: (details) {
                        bloc.add(LongPressStartEvent());
                        myCustomToast();
                      },
                      onLongPressEnd: (details) {
                        bloc.add(LongPressEndEvent());

                        Fluttertoast.cancel();
                      },
                      child: videoPlayerController.value.isInitialized
                          ? Transform.scale(
                              scale: state.scale,
                              child: AspectRatio(
                                aspectRatio:
                                    videoPlayerController.value.aspectRatio,
                                child: FittedBox(
                                  fit: state.fit,
                                  child: SizedBox(
                                    height: videoPlayerController
                                        .value.size.height.h,
                                    width: videoPlayerController
                                        .value.size.width.w,
                                    child: VideoPlayer(videoPlayerController),
                                  ),
                                ),
                              ))
                          : const Center(child: CircularProgressIndicator())),
                ),
                state.onTap ? OnTapClass(title: title) : Container()
              ],
            ),
          ),
        );
      }),
    ));
  }
}
