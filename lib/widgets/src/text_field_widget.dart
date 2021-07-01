part of '../widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget prefixIcon;
  final String value;

  TextFieldWidget({
    @required this.hintText,
    @required this.keyboardType,
    @required this.obscureText,
    this.prefixIcon,
    this.value,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController valueCtrl = TextEditingController();
  String valueStr;
  @override
  void initState() {
    super.initState();
    valueCtrl.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).primaryColor,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyText2,
      autocorrect: false,
      controller: valueCtrl,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.subtitle2,
        prefixIcon: widget.prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
//            color: kErrorColor,
              ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
//            color: kErrorColor,
              ),
        ),
      ),
    );
  }
}
