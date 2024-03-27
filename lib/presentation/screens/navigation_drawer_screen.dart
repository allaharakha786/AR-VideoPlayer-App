import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/bottomNavigationBloc/navigation_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/bottomNavigationBloc/navigation_events.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/dimentions_resources.dart';
import 'package:videoplayer/helper/constants/image_resources.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';
import 'package:videoplayer/helper/utills/text_styles.dart';
import 'package:videoplayer/presentation/screens/pick_file_screen.dart';
import 'package:videoplayer/presentation/screens/video_list_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List pages = [const VideoListPage(), const PickFileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, int>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorsResources.TILES_COLORS,
            leading: Padding(
              padding: const EdgeInsets.only(
                  left: DimensionsResource.PADDING_SIZE_LARGE,
                  bottom: DimensionsResource.PADDING_SIZE_SMALL),
              child: Image.asset(ImageResources.APP_LOGO),
            ),
            title: Text(
              StringResources.AR_PLAYER,
              style: MyTextStyle.appbarStyle(context),
            )),
        body: pages[state],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0.5,
            selectedItemColor: ColorsResources.BLACK_COLOR_54,
            backgroundColor: ColorsResources.TILES_COLORS,
            type: BottomNavigationBarType.fixed,
            currentIndex: state,
            onTap: (value) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(OnTapEvent(index: value));
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: StringResources.VIDEOS),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.file_open),
                  label: StringResources.PICK_VIDEOS),
            ]),
      ),
    );
  }
}
