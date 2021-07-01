part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }


  Future<List> dosomestuff() async {
    print('run');
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/settings/user/2170',
    );

    Map<String, dynamic> map = json.decode(res.body);
    print(map);
    print(map['Status']);
    if (int.parse(map['Status']) == 1) {
      // Fluttertoast.showToast(
      //     msg: "Setting api successfully run",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      print('aga chal');
      Glocation = map['LocationID'].toString();
      Guser = map['UserID'].toString();

      final storage = new FlutterSecureStorage();
      await storage.write(
          key: '_LocationID', value: map['LocationID'].toString());
      await storage.write(key: '_UserID', value: map['UserID'].toString());
      await storage.write(
          key: '_TaxPercentTaxPercent', value: map['TaxPercent']);
      await storage.write(
          key: '_DeliveryCharges', value: map['DeliveryCharges']);
      await storage.write(key: '_Currency', value: map['Currency']);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashWelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kPrimaryColor,
        child: Stack(children: [
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: Image.asset('assets/icons/logo.png'))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Image.asset(
                          'assets/images/Logo-Verticle-White-Square.png'))))
        ]));
    // return AnimatedSplashScreen(
    //   backgroundColor: kPrimaryColor,
    //   splash: 'assets/icons/logo.png',
    //   nextScreen: SplashWelcomePage(),
    //   splashTransition: SplashTransition.fadeTransition,
    //   pageTransitionType: PageTransitionType.fade,
    //   duration: 1500,
    //   animationDuration: Duration(milliseconds: 1500),
    // );
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(result);
    print(ConnectivityResult);

    if (result == ConnectivityResult.wifi) {
      print('wifi');
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print('connection have');

        dosomestuff();
      } else {
        // Mobile data detected but no internet connection found.
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: Dialog(
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Icon(
                                        Icons.wifi_off,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'No Internet Access',
                                      style: Theme.of(context).textTheme.headline1,
                                    ).tr(),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'Your wifi have no internet access',
                                      style: Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ).tr(),
                                    SizedBox(height: 20),
                                    RaisedButtonWidget(
                                        title: 'Change',
                                        onPressed: () => {
                                          AppSettings.openWIFISettings()
                                        }

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 450),
            barrierDismissible: false,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      }

    }
    if (result == ConnectivityResult.mobile) {
      print('mobile');
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print('connection have');
        dosomestuff();
      } else {
        // Mobile data detected but no internet connection found.
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: Dialog(
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Icon(
                                        Icons.wifi_off,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'No Internet Access',
                                      style: Theme.of(context).textTheme.headline1,
                                    ).tr(),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'Your data have no internet access',
                                      style: Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ).tr(),
                                    SizedBox(height: 20),
                                    RaisedButtonWidget(
                                        title: 'Change',
                                        onPressed: () => {
                                          AppSettings.openDateSettings()
                                        }

                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 450),
            barrierDismissible: false,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      }
    }
    if (result == ConnectivityResult.none) {
      print('none');
      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: Dialog(
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Icon(
                                      Icons.wifi_off,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'No Internet Connection',
                                    style: Theme.of(context).textTheme.headline1,
                                  ).tr(),
                                  SizedBox(height: 12.0),
                                  Text(
                                    'Your wifi or cellular data is not open.',
                                    style: Theme.of(context).textTheme.bodyText2,
                                    textAlign: TextAlign.center,
                                  ).tr(),
                                  SizedBox(height: 20),
                                  RaisedButtonWidget(
                                      title: 'Open',
                                      onPressed: () => {
                                      AppSettings.openWIFISettings()
                                      }

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 450),
          barrierDismissible: false,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {});

    }
  }
}

class SplashWelcomePage extends StatefulWidget {
  @override
  _SplashWelcomePageState createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  String _LocationID;
  String _UserID;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initState() {
    super.initState();
    dosomestuff();

  }

  Future<List> dosomestuff() async {
    // Fluttertoast.showToast(
    //     msg: "menu api start running loc Id = ${_LocationID} user id =${_UserID}",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
    //
    // print(_LocationID);
    //
    // print(_UserID);
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/menu/${Glocation}/${Guser}',
    );
    // globalArray.globalArrayData = res.body;

    Map<String, dynamic> map = json.decode(res.body);

    if (map['description'] == "Success") {
      // Fluttertoast.showToast(
      //     msg: "menu api hit success start time run it will go to on boarding or home page",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      //print('show kr ');
      startTime();
    }
  }

  startTime() {
    Timer(
      Duration(milliseconds: 1000),
      () async {
        Get.offAll(BottomNavigationBarPage());

        // final storage = new FlutterSecureStorage();
        //
        // String board = await storage.read(key: "board");
        // //print(board);
        // if (board == "yes") {
        //   Fluttertoast.showToast(
        //       msg: "Hit to home",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0
        //   );
        //   Get.offAll(BottomNavigationBarPage());
        //
        //   //print('home pa bhejo');
        // } else {
        //   Fluttertoast.showToast(
        //       msg: "Hit to boarding",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0
        //   );
        //   //print('board pa bhejo');
        //   Get.offAll(
        //     OnBoardingPage(),
        //     // transition: Transition.topLevel,
        //     // duration: Duration(milliseconds: 2500),
        //   );
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const SpinKitWave(
            color: kPrimaryColor, type: SpinKitWaveType.center),
      ),
    );
  }


}
