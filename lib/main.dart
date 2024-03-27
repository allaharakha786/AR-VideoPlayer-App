import 'package:flutter/material.dart';
import 'package:videoplayer/businessLogic/blocs/bottomNavigationBloc/navigation_bloc.dart';
import 'package:videoplayer/businessLogic/blocs/videoPlayerBloc/video_player_bloc.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoplayer/presentation/screens/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VideoPlayerBloc(),
          ),
          BlocProvider(
            create: (context) => NavigationBloc(),
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            iconTheme: IconThemeData(color: ColorsResources.WHITE_COLOR),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
