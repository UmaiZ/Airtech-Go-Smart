part of 'helpers.dart';

Future showToast(
    {@required String msg, Color backgroundColor, Color textColor}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 16.0,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? kPrimaryColor,
    textColor: textColor ?? Colors.white,
  );
}
