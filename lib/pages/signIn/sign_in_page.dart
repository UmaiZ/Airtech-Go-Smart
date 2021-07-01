part of '../pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
  bool _passwordVisible = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  @override
  Widget build(BuildContext context) {
    // final signInProv = Provider.of<SignInProvider>(context);

    Future<http.Response> _login() async {
      final FacebookLogin facebookSignIn = new FacebookLogin();

      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);


      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          print(accessToken);
          final String token = accessToken.token;

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                    child: const SpinKitWave(
                        color: kPrimaryColor, type: SpinKitWaveType.center));
              });

          final response = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
          final profile = jsonDecode(response.body);
          print(profile);


          String url =
              'http://retailapi.airtechsolutions.pk/api/customer/login/${profile['email']}/null/sm';

          //print(url);
          http.Response res = await http.get(
            url,
          );
          var data = json.decode(res.body.toString());
          //print(data);

          if (data['description'].toString() == "Success") {
            //print('hogya');
            Navigator.pop(context);
            //print(data['customer']['Addresses']);
            //print(data['customer']['CustomerID']);
            //print(data['customer']['Email']);
            //print(data['customer']['FullName']);
            final _storage = FlutterSecureStorage();

            await _storage.write(key: 'imei', value: 'loginhuavaha');
            await _storage.write(key: '_userEmail', value: _userEmail.trim());
            await _storage.write(
                key: '_userPassword', value: _userPassword.trim());
            await _storage.write(
                key: '_userID', value: data['customer']['CustomerID'].toString());
            await _storage.write(
                key: '_userEmail', value: data['customer']['Email'].toString());
            await _storage.write(
                key: '_userName', value: profile['name']);
            navigateToHomePage(context);
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

          print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }


    Future<http.Response> _loginGooGle() async {

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
                child: const SpinKitWave(
                    color: kPrimaryColor, type: SpinKitWaveType.center));
          });

      showToast(msg: 'Google Sign In Clicked!');
      try{
        await _googleSignIn.signIn();
        print(_googleSignIn.currentUser.displayName);
        print(_googleSignIn.currentUser.photoUrl);
        print(_googleSignIn.currentUser.id);
        print(_googleSignIn.currentUser.email);


        String url =
            'http://retailapi.airtechsolutions.pk/api/customer/login/${_googleSignIn.currentUser.email}/null/sm';

        //print(url);
        http.Response res = await http.get(
          url,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'].toString() == "Success") {
          //print('hogya');
          Navigator.pop(context);
          //print(data['customer']['Addresses']);
          //print(data['customer']['CustomerID']);
          //print(data['customer']['Email']);
          //print(data['customer']['FullName']);
          final _storage = FlutterSecureStorage();

          await _storage.write(key: 'imei', value: 'loginhuavaha');
          await _storage.write(key: '_userEmail', value: _userEmail.trim());
          await _storage.write(
              key: '_userPassword', value: _userPassword.trim());
          await _storage.write(
              key: '_userID', value: data['customer']['CustomerID'].toString());
          await _storage.write(
              key: '_userEmail', value: data['customer']['Email'].toString());
          await _storage.write(
              key: '_userName', value: _googleSignIn.currentUser.displayName);
          navigateToHomePage(context);
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


      } catch (err){
        print(err);
      }



    }


    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();

      if (isValid) {
        _formKey.currentState.save();

        //print(_userEmail.trim());
        //print(_userPassword.trim());


        String url =
            'http://retailapi.airtechsolutions.pk/api/customer/login/${_userEmail.trim()}/${_userPassword.trim()}/0';

        //print(url);
        http.Response res = await http.get(
          url,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'].toString() == "Success") {
          //print('hogya');
          Navigator.pop(context);
          //print(data['customer']['Addresses']);
          //print(data['customer']['CustomerID']);
          //print(data['customer']['Email']);
          //print(data['customer']['FullName']);
          final _storage = FlutterSecureStorage();

          await _storage.write(key: 'imei', value: 'loginhuavaha');
          await _storage.write(key: '_userEmail', value: _userEmail.trim());
          await _storage.write(
              key: '_userPassword', value: _userPassword.trim());
          await _storage.write(
              key: '_userID', value: data['customer']['CustomerID'].toString());
          await _storage.write(
              key: '_userEmail', value: data['customer']['Email'].toString());
          await _storage.write(
              key: '_userName', value: data['customer']['FullName'].toString());
          navigateToHomePage(context);
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
                    obscureText:
                        !_passwordVisible, //This will obscure text dynamically

                    style: Theme.of(context).textTheme.bodyText2,
                    autocorrect: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
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
                  SizedBox(height: 15.0),
                  buildForgotPasswordButton(context),
                  SizedBox(height: 20.0),
                  SideInAnimation(
                    4,
                    child: RaisedButtonWidget(
                      title: 'signin.signin',
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
                  GestureDetector(
                    onTap: (){
                      _login();
                    },
                    child: SizedBox(
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
                                'Sign in with Facebook',
                                style: Theme.of(context).textTheme.bodyText2,
                              ).tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: (){
                      _loginGooGle();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 20.0,
                            top: 15.0,
                            bottom: 15.0,
                            child: Image.asset(
                              'assets/images/google_logo.png',
                            ),
                          ),
                          OutlineButton(
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
                                'Sign in with Google',
                                style: Theme.of(context).textTheme.bodyText2,
                              ).tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
              'signin.noaccount',
              style: Theme.of(context).textTheme.subtitle1,
            ).tr(),
            SizedBox(width: 7.0),
            GestureDetector(
              onTap: navigateToSignUp,
              child: Text(
                'signin.register',
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

  FadeInAnimation buildFacebookSignInButton(BuildContext context) {
    return FadeInAnimation(
      6,
      child: FacebookSignInButtonWidget(
        title: 'signin.facebook',
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


  SideInAnimation buildSubtitle(BuildContext context) {
    return SideInAnimation(
      2,
      child: Text(
        'signin.subtitle',
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
    Get.to(SignUpPage());
  }

  void navigateToForgotPassword() {
    Get.to(ForgotPasswordPage());
  }

  navigateToHomePage(BuildContext context) {
    Get.offAll(BottomNavigationBarPage());
  }

  // facebookSignInClicked(BuildContext context) {
  //   showToast(msg: 'Facebook Sign In Clicked!');
  //   _login();
  // }



  googleSignInClicked() async{
    showToast(msg: 'Google Sign In Clicked!');
    try{
      await _googleSignIn.signIn();
      print(_googleSignIn.currentUser.displayName);
      print(_googleSignIn.currentUser.photoUrl);
      print(_googleSignIn.currentUser.id);
      print(_googleSignIn.currentUser.email);



    } catch (err){
      print(err);
    }

  }
}
