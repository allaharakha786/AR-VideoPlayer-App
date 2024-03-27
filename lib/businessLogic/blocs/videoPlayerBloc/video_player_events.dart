import 'package:video_player/video_player.dart';

abstract class VideoPlayerEvents {}

class LongPressStartEvent extends VideoPlayerEvents {}

class PlayBackSpeedEvent extends VideoPlayerEvents {
  double speed;
  PlayBackSpeedEvent({required this.speed});
}

class LongPressEndEvent extends VideoPlayerEvents {}

class AddListnerEvent extends VideoPlayerEvents {
  double value;
  AddListnerEvent({required this.value});
}

class IntializationEvent extends VideoPlayerEvents {
  VideoPlayerController controller;
  IntializationEvent({required this.controller});
}

class ChangeVolumeEvent extends VideoPlayerEvents {
  double volume;
  ChangeVolumeEvent({required this.volume});
}

class DisposeEvent extends VideoPlayerEvents {}

class GetScreenBrightnessEvent extends VideoPlayerEvents {}

class SetScreenBrightnessEvent extends VideoPlayerEvents {
  double value;
  SetScreenBrightnessEvent({required this.value});
}

class SkipPreviousEvent extends VideoPlayerEvents {}

class SkipNextEvent extends VideoPlayerEvents {}

class OriginalZoomEvent extends VideoPlayerEvents {}

class CropZoomEvent extends VideoPlayerEvents {}

class StrechZoomEvent extends VideoPlayerEvents {}

class ShowControllerEvent extends VideoPlayerEvents {}

class PickFileEvent extends VideoPlayerEvents {}

class IsPortraitFalseEvent extends VideoPlayerEvents {}

class IsPortraitTrueEvent extends VideoPlayerEvents {}

class ScaleEvent extends VideoPlayerEvents {
  double previousScale;
  double detailsScale;
  ScaleEvent({required this.detailsScale, required this.previousScale});
}

class AddVideoFilesEvent extends VideoPlayerEvents {
  String videoPath;
  String thumbnail;
  AddVideoFilesEvent({required this.videoPath, required this.thumbnail});
}

class GetVideosEvent extends VideoPlayerEvents {}

class VideoSliderValueEvent extends VideoPlayerEvents {
  double value;
  VideoSliderValueEvent({required this.value});
}

class PlayVideoEvent extends VideoPlayerEvents {}

class PauseVideoEvent extends VideoPlayerEvents {}

class SliderValueEvent extends VideoPlayerEvents {
  double value;
  SliderValueEvent({required this.value});
}
