part of '../pages.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            buildIllustration(context),
            SizedBox(height: 25.0),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: <Widget>[
                    buildTitleAndDescription(context),
                    SizedBox(height: 20.0),
                    buildEmailTextField(),
                    SizedBox(height: 38.0),
                  ],
                ),
              ),
            ),
            buildButtonResetPassword(),
          ],
        ),
      ),
    );
  }

  FadeInAnimation buildEmailTextField() {
    return FadeInAnimation(
      2,
      child: TextFormFieldWidget(
        hintText: tr('forgotpassword.email'),
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        prefixIcon: Icon(FlutterIcons.mail_fea),
      ),
    );
  }

  FadeInAnimation buildButtonResetPassword() {
    return FadeInAnimation(
      2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: RaisedButtonWidget(
          title: 'forgotpassword.send',
          onPressed: () {
            showToast(msg: 'Reset Password Clicked!');
            Get.back();
          },
        ),
      ),
    );
  }

  FadeInAnimation buildTitleAndDescription(BuildContext context) {
    return FadeInAnimation(
      1,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: tr('forgotpassword.title'),
                style: Theme.of(context).textTheme.headline1),
            TextSpan(text: '\n\n'),
            TextSpan(
              text: tr('forgotpassword.subtitle'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildIllustration(BuildContext context) {
    return Flexible(
      flex: 1,
      child: FadeInAnimation(
        1,
        child: SvgPicture.asset(
          'assets/images/forgot_illustration.svg',
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }
}
