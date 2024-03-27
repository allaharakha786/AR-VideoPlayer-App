import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_events.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_states.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';
import 'package:videoplayer/helper/constants/screen_percentage.dart';
import 'package:videoplayer/helper/enums/status_enums.dart';
import 'package:videoplayer/helper/utills/permission_denied_dialog.dart';
import 'package:videoplayer/helper/utills/text_styles.dart';
import 'package:flutter/services.dart';

import 'package:videoplayer/presentation/screens/video_player_screen.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late VideoPlayerBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<VideoPlayerBloc>(context);
    if (bloc.videoPaths.isEmpty) {
      bloc.add(GetVideosEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<VideoPlayerBloc, VideoplayerStates>(
        listener: (context, state) {
          if (state.state == StatusEnum.PERMISSION_DENIED_STATE) {
            showDialog(
              context: context,
              builder: (context) => const PermissionDeniedDialog(),
            );
          }
        },
        child: BlocBuilder<VideoPlayerBloc, VideoplayerStates>(
          builder: (context, state) => Container(
            color: ColorsResources.BACKGROUND_COLORS,
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.videoPaths.length,
              itemBuilder: (context, index) {
                String fileName = state.videoPaths[index].split('/').last;
                if (state.videoPaths.isNotEmpty) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                  path: state.videoPaths[index]),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(
                            DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorsResources.WHITE_COLOR),
                              color: ColorsResources.TILES_COLORS,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      DimensionsResource.RADIUS_DEFAULT.sp),
                                  bottomRight: Radius.circular(
                                      DimensionsResource.RADIUS_DEFAULT.sp))),
                          height: mediaQuerySize.height *
                              ScreenPercentage.SCREEN_SIZE_9.h,
                          width: mediaQuerySize.width *
                              ScreenPercentage.SCREEN_SIZE_100.w,
                          child: ListTile(
                            leading: SizedBox(
                              height: mediaQuerySize.height *
                                  ScreenPercentage.SCREEN_SIZE_8.h,
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_23.w,
                              child: Image.file(
                                  fit: BoxFit.cover,
                                  File(state.thumbnails[index])),
                            ),
                            title: FittedBox(
                              child: Text(
                                "   ${fileName.length < 17 ? fileName.substring(0, fileName.length) : '${fileName.substring(0, 16)}...'} ",
                                style: MyTextStyle.videosTitleStyle(context),
                              ),
                            ),
                          ),
                        ),
                      ));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
