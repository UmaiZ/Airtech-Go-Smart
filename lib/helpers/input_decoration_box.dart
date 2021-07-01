part of 'helpers.dart';

InputDecoration kInputDecorationBox(BuildContext context, {icon, suffixIcon}) =>
    InputDecoration(
      prefixIcon: icon,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Theme.of(context).accentColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
