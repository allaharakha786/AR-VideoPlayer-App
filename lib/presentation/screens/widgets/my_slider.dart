import 'package:flutter/material.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';

// ignore: must_be_immutable
class MySlider extends StatelessWidget {
  double controllerValue;
  IconData startIcon;
  IconData endIcon;
  void Function(double)? onChange;

  MySlider(
      {super.key,
      required this.controllerValue,
      required this.startIcon,
      required this.endIcon,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return InteractiveSlider(
      iconPosition: IconPosition.inline,
      brightness: Brightness.light,
      controller: InteractiveSliderController(controllerValue),
      backgroundColor: ColorsResources.BLUE_300,
      startIcon: Icon(color: ColorsResources.WHITE_COLOR, startIcon),
      endIcon: Icon(
        endIcon,
        color: ColorsResources.WHITE_COLOR,
      ),
      onChanged: onChange,
      min: 0.0,
      max: 1.0,
    );
  }
}
