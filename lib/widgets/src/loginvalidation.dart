part of '../widgets.dart';


class LoginKro extends StatefulWidget {
  @override
  _LoginKroState createState() => _LoginKroState();
}

class _LoginKroState extends State<LoginKro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/undraw_Login_re_4vu2.png',
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'You are not Login ',
                    style: Theme.of(context).textTheme.headline1,
                  ).tr(),
                  SizedBox(height: 15.0),
                  Text(
                    'Please Login to proceed more. Happy Shopping  :)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ).tr(),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 85.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.button,
                      ).tr(),
                      onPressed: () {
                        Get.to(SignInPage());
                      },
                    ),
                  ),
                ])),
      )
    );
  }
}
