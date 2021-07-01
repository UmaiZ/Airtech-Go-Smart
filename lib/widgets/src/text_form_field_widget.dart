part of '../widgets.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget prefixIcon;
  final String value;

  TextFormFieldWidget({
    @required this.hintText,
    @required this.keyboardType,
    @required this.obscureText,
    this.prefixIcon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyText2,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle2,
        prefixIcon: prefixIcon,
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
              color: Theme.of(context).errorColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            )),
      ),
    );
  }
}
