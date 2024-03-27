import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_events.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_states.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/screen_percentage.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';
import 'package:videoplayer/helper/enums/status_enums.dart';
import 'package:videoplayer/presentation/screens/video_player_screen.dart';

class PickFileScreen extends StatelessWidget {
  const PickFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return BlocListener<VideoPlayerBloc, VideoplayerStates>(
      listener: (context, state) {
        if (state.state == StatusEnum.FILE_PICKED_STATE) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VideoPlayerScreen(path: state.pickedFileUrl),
              ));
        }
      },
      child: BlocBuilder<VideoPlayerBloc, VideoplayerStates>(
        builder: (context, state) => Scaffold(
          body: Container(
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            color: ColorsResources.BACKGROUND_COLORS,
            child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            ColorsResources.TILES_COLORS)),
                    onPressed: () {
                      BlocProvider.of<VideoPlayerBloc>(context)
                          .add(PickFileEvent());
                    },
                    child: Text(
                      StringResources.PICK_VIDEOS,
                      style: TextStyle(color: ColorsResources.BLACK_COLOR),
                    ))),
          ),
        ),
      ),
    );
  }
}
