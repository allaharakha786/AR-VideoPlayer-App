import 'package:fluttertoast/fluttertoast.dart';
import 'package:videoplayer/helper/constants/colors_resources.dart';
import 'package:videoplayer/helper/constants/string_resources.dart';

void myCustomToast() {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      textColor: ColorsResources.BLACK_COLOR,
      gravity: ToastGravity.TOP,
      msg: StringResources.SPEED_2X,
      backgroundColor: ColorsResources.BLUE_300);
}
