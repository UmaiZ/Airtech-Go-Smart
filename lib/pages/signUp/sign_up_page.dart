part of '../pages.dart';

class SignUpPage extends StatelessWidget {
  void navigateToSignInPage() {
    Get.back();
  }

  void navigateToHomePage() {
    Get.to(BottomNavigationBarPage());
  }

  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  var _userPhone = '';

  @override
  Widget build(BuildContext context) {
    // final signInProv = Provider.of<SignInProvider>(context);

    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();

        //print(_userEmail.trim());
        //print(_userPassword.trim());
        //print(_userPhone.trim());
        //print(_userName.trim());

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(
                      color: kPrimaryColor, type: SpinKitWaveType.center));
            });

        String url =
            'http://retailapi.airtechsolutions.pk/api/customer/signup/${_userEmail.trim()}/${_userPassword.trim()}';
        Map<String, dynamic> body = {
          "CustomerID": 0,
          "FullName": _userName.trim(),
          "Mobile": _userPhone.trim(),
          "Password": _userPassword.trim(),
          "Email": _userEmail.trim(),
          "UserID": 2141
        };
        String jsonBody = json.encode(body);
        final headers = {'Content-Type': 'application/json'};

        //print(url);
        http.Response res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/customer/signup',
          headers: headers,

          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'].toString() == "Your account has been registered successfully.") {
          //print('hogya');
          Navigator.pop(context);

          navigateToSignInPage();
          Fluttertoast.showToast(
              msg: "Registration Successfull.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          // navigateToHomePage();
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Something went wrong.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        //

       }
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0),
                  buildIcon(context),
                  SizedBox(height: 18.0),
                  buildTitle(context),
                  SizedBox(height: 12.0),
                  buildSubtitle(context),
                  SizedBox(height: 35.0),
                  TextFormField(
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
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
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.mail_fea),
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
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    key: ValueKey('phone'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a number.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPhone = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.phone_mco),
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
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid Password.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      prefixIcon: Icon(FlutterIcons.lock_fea),
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
                  ),
                  SizedBox(height: 20.0),
                  SideInAnimation(
                    4,
                    child: RaisedButtonWidget(
                      title: 'Register',
                      onPressed: () async {
                        _trySubmit();

                        // navigateToHomePage(context);
                        // final _storage = FlutterSecureStorage();
                        //
                        // await _storage.write(key: 'imei', value: 'loginhuavaha');
                      },
                    ),
                  ),
                  
                  
                  SizedBox(height: 15.0),
                  buildSignUpButton(context),
                  SizedBox(height: 15.0),
                  // Text(tr('ewew'))
                ],
              ),
            )),
      ),
    );
  }

  FadeInAnimation buildDivider(BuildContext context) {
    return FadeInAnimation(
      5,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              height: .5,
              color: Theme.of(context).accentColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'signin.or',
              style: Theme.of(context).textTheme.subtitle2,
            ).tr(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: .5,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

  FadeInAnimation buildSignUpButton(BuildContext context) {
    return FadeInAnimation(
      7,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: Theme.of(context).textTheme.subtitle1,
            ).tr(),
            SizedBox(width: 7.0),
            GestureDetector(
              onTap: navigateToSignUp,
              child: Text(
                'Sign in',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Theme.of(context).primaryColor),
              ).tr(),
            )
          ],
        ),
      ),
    );
  }

  FadeInAnimation buildFacebookSignInButton() {
    return FadeInAnimation(
      6,
      child: FacebookSignInButtonWidget(
        title: 'signin.facebook',
        onPressed: facebookSignInClicked,
      ),
    );
  }

  FadeInAnimation buildGoogleSignInButton() {
    return FadeInAnimation(
      5,
      child: GoogleSignInButtonWidget(
        title: 'signin.google',
        onPressed: googleSignInClicked,
      ),
    );
  }

  // SideInAnimation buildSignInButton(BuildContext context) {
  //   return SideInAnimation(
  //     4,
  //     child: RaisedButtonWidget(
  //       title: 'signin.signin',
  //       onPressed: () async {
  //         _trySubmit();
  //
  //         // navigateToHomePage(context);
  //         // final _storage = FlutterSecureStorage();
  //         //
  //         // await _storage.write(key: 'imei', value: 'loginhuavaha');
  //       },
  //     ),
  //   );
  // }

  SideInAnimation buildForgotPasswordButton(BuildContext context) {
    return SideInAnimation(
      4,
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: navigateToForgotPassword,
          child: Text(
            'signin.forgot',
            style:
            Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0),
          ).tr(),
        ),
      ),
    );
  }

  SideInAnimation buildPasswordTextField() {
    return SideInAnimation(
      3,
      child: TextFormFieldWidget(
        obscureText: true,
        hintText: tr('signin.password'),
        keyboardType: TextInputType.text,
        prefixIcon: Icon(FlutterIcons.lock_fea),
      ),
    );
  }

  // SideInAnimation buildEmailTextField() {
  //   return SideInAnimation(
  //     3,
  //     child: TextFormField(
  //       cursorColor: Theme.of(context).primaryColor,
  //       obscureText: false,
  //       keyboardType: TextInputType.emailAddress,
  //       style: Theme.of(context).textTheme.bodyText2,
  //       autocorrect: false,
  //       decoration: InputDecoration(
  //         hintText: 'Email Address',
  //         hintStyle: Theme.of(context).textTheme.subtitle2,
  //         prefixIcon: Icon(FlutterIcons.mail_fea),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //           borderSide: BorderSide(
  //             color: Theme.of(context).accentColor.withOpacity(.4),
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12.0),
  //           borderSide: BorderSide(
  //             color: Theme.of(context).primaryColor,
  //           ),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.0),
  //             borderSide: BorderSide(
  //               color: Theme.of(context).errorColor,
  //             )),
  //         errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.0),
  //             borderSide: BorderSide(
  //               color: Theme.of(context).errorColor,
  //             )),
  //       ),
  //     )
  //
  //
  //
  //
  //
  //   );
  // }

  SideInAnimation buildSubtitle(BuildContext context) {
    return SideInAnimation(
      2,
      child: Text(
        'Signup to continue',
        style: Theme.of(context).textTheme.subtitle1,
      ).tr(),
    );
  }

  SideInAnimation buildTitle(BuildContext context) {
    return SideInAnimation(
      2,
      child: Text(
        'signin.title',
        style: Theme.of(context).textTheme.headline1,
      ).tr(),
    );
  }

  SideInAnimation buildIcon(BuildContext context) {
    return SideInAnimation(
      1,
      child: Center(
        child: Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: kBackgroundLightColor,
              size: 45.0,
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSignUp() {
    Get.to(SignInPage());
  }

  void navigateToForgotPassword() {
    Get.to(ForgotPasswordPage());
  }



  facebookSignInClicked() {
    showToast(msg: 'Facebook Sign In Clicked!');
  }

  googleSignInClicked() {
    showToast(msg: 'Google Sign In Clicked!');
  }
}
