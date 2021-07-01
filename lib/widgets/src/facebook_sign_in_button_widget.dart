part of '../widgets.dart';

class FacebookSignInButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const FacebookSignInButtonWidget(
      {Key key, this.title,  this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20.0,
            top: 10.0,
            bottom: 10.0,
            child: Image.asset(
              'assets/images/facebook.png',
            ),
          ),
          OutlineButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
            ),
            highlightedBorderColor: Theme.of(context).accentColor,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText2,
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}
