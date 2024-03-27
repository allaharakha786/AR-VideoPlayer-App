import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:videoplayer/helper/enums/status_enums.dart';

import 'video_player_events.dart';
import 'video_player_states.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvents, VideoplayerStates> {
  late VideoPlayerController videoPlayerController;
  BoxFit fit = BoxFit.contain;
  double sliderValue = 0.0;
  late double brightness;
  double scale = 1.0;
  List<String> videoPaths = [];
  List<String> thumbnails = [];
  Timer? _hideControlsTimer;
  bool ontap = false;

  VideoPlayerBloc()
      : super(VideoplayerStates(
          isPlaying: true,
          isPortrait: false,
          onTap: false,
          sliderValue: 0.0,
          controller: VideoPlayerController.asset(''),
        )) {
    on<LongPressStartEvent>(longPressStartMethod);
    on<PlayBackSpeedEvent>(playbackSpeedMethod);

    on<LongPressEndEvent>(longPressEndMethod);

    on<IntializationEvent>(intializeVideoMethod);
    on<SliderValueEvent>(sliderValueMethod);

    on<GetScreenBrightnessEvent>(currentBrightnessMethod);
    on<SetScreenBrightnessEvent>(setScreenBrightnessMethod);
    on<SkipNextEvent>(skipNextMethod);
    on<SkipPreviousEvent>(skipPreviousMethod);
    on<OriginalZoomEvent>(originalZoomMethod);
    on<CropZoomEvent>(cropZoomMethod);
    on<StrechZoomEvent>(strechZoomMetho);
    on<ChangeVolumeEvent>(changeVolumeMethod);
    on<PlayVideoEvent>(playMethod);
    on<PauseVideoEvent>(pauseMethod);
    on<AddListnerEvent>(addListnerMethod);

    on<IsPortraitFalseEvent>(isPortrateFalseMethod);
    on<IsPortraitTrueEvent>(isPortrateTrueMethod);
    on<ScaleEvent>(scaleMethod);
    on<GetVideosEvent>(getVideoMethod);
    on<ShowControllerEvent>(showControllersMethod);
    on<PickFileEvent>(pickFileMethod);
  }
  pickFileMethod(PickFileEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: true, type: FileType.video);
      if (result != null) {
        String fileName = result.files.single.path ?? '';
        emit(state.copyWith(
            state: StatusEnum.FILE_PICKED_STATE, pickedFileUrl: fileName));
      }
    } catch (e) {
      emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  showControllersMethod(
      ShowControllerEvent event, Emitter<VideoplayerStates> emit) {
    ontap = !ontap;
    emit(state.copyWith(onTap: ontap));
    if (state.onTap) {
      _hideControlsTimer?.cancel();
      _hideControlsTimer = Timer(const Duration(seconds: 3), () {
        ontap = true;
        emit(state.copyWith(onTap: ontap));
      });
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  getVideoMethod(GetVideosEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        List<Directory> directories = [
          Directory('/storage/emulated/0/Download'),
          Directory('/storage/emulated/0/DCIM/Camera'),
          Directory('/storage/emulated/0/DCIM'),
          Directory('/storage/emulated/0/')
        ];

        for (var directory in directories) {
          if (!directory.existsSync()) {
            directory.createSync(recursive: true);
          }
          List<FileSystemEntity> fileList = directory.listSync(recursive: true);
          for (var file in fileList) {
            if (file is File && file.path.endsWith('.mp4')) {
              String? thumbnail = await VideoThumbnail.thumbnailFile(
                  video: file.path,
                  imageFormat: ImageFormat.JPEG,
                  maxHeight: 120,
                  maxWidth: 120,
                  quality: 100);
              videoPaths.add(file.path);
              thumbnails.add(thumbnail ?? '');
              emit(state.copyWith(
                  videoPaths: videoPaths, thumbnails: thumbnails));
            }
          }
        }
      } else {
        emit(state.copyWith(state: StatusEnum.PERMISSION_DENIED_STATE));
      }
    } catch (e) {
      emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  scaleMethod(ScaleEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      scale = event.previousScale * event.detailsScale;
      emit(state.copyWith(scale: scale));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  isPortrateFalseMethod(
      IsPortraitFalseEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      emit(state.copyWith(isPortrait: false));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  isPortrateTrueMethod(
      IsPortraitTrueEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      emit(state.copyWith(isPortrait: true));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  addListnerMethod(
      AddListnerEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      videoPlayerController.addListener(() {
        sliderValue = event.value;
      });
      emit(state.copyWith(sliderValue: sliderValue));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  strechZoomMetho(StrechZoomEvent event, Emitter<VideoplayerStates> emit) {
    try {
      fit = BoxFit.fill;
      emit(state.copyWith(fit: fit));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  playMethod(PlayVideoEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      await videoPlayerController.play();
      emit(state.copyWith(isPlaying: true));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  sliderValueMethod(
      SliderValueEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      double newValue = event.value;
      sliderValue = newValue;

      emit(state.copyWith(sliderValue: sliderValue));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  pauseMethod(PauseVideoEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      await videoPlayerController.pause();

      emit(state.copyWith(isPlaying: false));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  changeVolumeMethod(
      ChangeVolumeEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      await videoPlayerController.setVolume(event.volume);
      emit(state.copyWith(volume: event.volume));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  cropZoomMethod(CropZoomEvent event, Emitter<VideoplayerStates> emit) {
    try {
      fit = BoxFit.cover;
      emit(state.copyWith(fit: fit));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  originalZoomMethod(OriginalZoomEvent event, Emitter<VideoplayerStates> emit) {
    try {
      fit = BoxFit.contain;
      emit(state.copyWith(fit: fit));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  skipPreviousMethod(SkipPreviousEvent event, Emitter<VideoplayerStates> emit) {
    try {
      videoPlayerController.seekTo(Duration(
          seconds: videoPlayerController.value.position.inSeconds - 5));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  skipNextMethod(SkipNextEvent event, Emitter<VideoplayerStates> emit) {
    try {
      videoPlayerController.seekTo(Duration(
          seconds: videoPlayerController.value.position.inSeconds + 5));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  currentBrightnessMethod(
      GetScreenBrightnessEvent event, Emitter<VideoplayerStates> emit) async {
    brightness = await ScreenBrightness().current;

    emit(state.copyWith(
      brightness: brightness,
    ));
  }

  setScreenBrightnessMethod(
      SetScreenBrightnessEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      await ScreenBrightness.instance.setScreenBrightness(event.value);
      brightness = event.value;
      return emit(state.copyWith(
        brightness: brightness,
      ));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  intializeVideoMethod(
      IntializationEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      videoPlayerController = event.controller;
      emit(state.copyWith(
          state: StatusEnum.VIDEO_INITIALZED_STATE,
          controller: videoPlayerController));
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  playbackSpeedMethod(
      PlayBackSpeedEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      videoPlayerController.setPlaybackSpeed(event.speed);
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  longPressStartMethod(
      LongPressStartEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      videoPlayerController.setPlaybackSpeed(2.0);
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }

  longPressEndMethod(
      LongPressEndEvent event, Emitter<VideoplayerStates> emit) async {
    try {
      videoPlayerController.setPlaybackSpeed(1.0);
    } catch (e) {
      return emit(state.copyWith(state: StatusEnum.ERROR_STATE));
    }
  }
}
