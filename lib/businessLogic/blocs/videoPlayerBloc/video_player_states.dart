import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/helper/enums/status_enums.dart';

class VideoplayerStates {
  StatusEnum state;
  VideoPlayerController? controller;
  double brightness;
  BoxFit fit;
  double volume;
  bool? isPlaying;
  double sliderValue;
  bool onTap;
  double scale;
  bool? isPortrait;
  List<String> videoPaths;
  List<String> thumbnails;
  String pickedFileUrl;

  VideoplayerStates(
      {this.state = StatusEnum.INITIAL_STATE,
      this.controller,
      this.brightness = 0.7,
      this.fit = BoxFit.contain,
      this.volume = 0.5,
      this.isPlaying,
      this.sliderValue = 0.0,
      this.onTap = false,
      this.isPortrait,
      this.scale = 1.0,
      this.videoPaths = const [],
      this.thumbnails = const [],
      this.pickedFileUrl = ''});

  VideoplayerStates copyWith(
      {StatusEnum? state,
      VideoPlayerController? controller,
      double? brightness,
      BoxFit? fit,
      double? volume,
      double? sliderValue,
      bool? isPlaying,
      bool? onTap,
      bool? isPortrait,
      double? scale,
      List<String>? videoPaths,
      List<String>? thumbnails,
      String? pickedFileUrl}) {
    return VideoplayerStates(
        controller: controller ?? this.controller,
        state: state ?? this.state,
        brightness: brightness ?? this.brightness,
        fit: fit ?? this.fit,
        volume: volume ?? this.volume,
        isPlaying: isPlaying ?? this.isPlaying,
        sliderValue: sliderValue ?? this.sliderValue,
        onTap: onTap ?? this.onTap,
        isPortrait: isPortrait ?? this.isPortrait,
        scale: scale ?? this.scale,
        videoPaths: videoPaths ?? this.videoPaths,
        thumbnails: thumbnails ?? this.thumbnails,
        pickedFileUrl: pickedFileUrl ?? this.pickedFileUrl);
  }

  List<Object> get props => [
        state,
        controller!,
        brightness,
        fit,
        volume,
        isPlaying!,
        sliderValue,
        onTap,
        isPortrait!,
        scale,
        videoPaths,
        thumbnails,
        pickedFileUrl
      ];
}
