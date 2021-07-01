part of '../pages.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _userID = "";
  num amount = 0;
  var items = [];

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;



  @override
  void initState() {
      this._query();
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

  void _query() async {


    //print('cart');
    final dbHelper = DatabaseHelper.instance;

    var allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      items.add(

          {
            "ItemID": row['id'],
            "ItemName": row['title'],
            "Quantity": 1,
            "Price": row['price'],
            "Cost": 0,
            "StatusID": 1,
            "OrderDetailModifiers": [
              {
                "ModifierID": 0,
                "ModifierName": row['color'],
                "Quantity": 0,
                "Price": 0,
                "Cost": 0,
                "StatusID": 1
              },
              {
                "ModifierID": 0,
                "ModifierName": row['sizeselect'],
                "Quantity": 0,
                "Price": 0,
                "Cost": 0,
                "StatusID": 1
              }
            ]

        }
      );
      amount += double.parse(row['price']);
      //print(amount);
      //print(row);
      //print(items);
    });
  }



  @override
  Widget build(BuildContext context) {

    onClick(){
      initConnectivity();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'order.payment',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: paymentList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final payment = paymentList[index];
                  return SideInAnimation(
                    index,
                    child: PaymentCard(
                      payment: payment,
                      onPressed: () {
                        setState(() {
                          paymentList.forEach((e) => e.isSelected = false);
                          payment.isSelected = true;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: FadeInAnimation(
                4,
                child: RaisedButtonWidget(
                  title: 'order.continue',
                  onPressed: () {

                    onClick();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(result);
    print(ConnectivityResult);

    if (result == ConnectivityResult.wifi) {
      print('wifi');
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print('connection have');

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center));
            });


        final storage = new FlutterSecureStorage();

        Map<String, dynamic> body = {
          "CustomerID": await storage.read(key: "_userID"),
          "OrderType": "APP",
          "OrderDate": "2021-01-28",
          "StatusID": 2,
          "LocationID": 2112,
          "OrderCheckouts": {
            "PaymentMode": 1,
            "AmountPaid": amount,
            "AmountTotal": amount,
            "ServiceCharges": 0,
            "GrandTotal": 0,
            "Tax": 0,
            "CheckoutDate": "2021-01-28",
            "StatusID": 2
          },
          "OrderDetails": items
        };
        String jsonBody = json.encode(body);
        //print(jsonBody);

        final headers = {'Content-Type': 'application/json'};

        http.Response res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/orders/new',
          headers: headers,

          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if(data['description'] == "Your order has been punched successfully."){
          Navigator.pop(context);
          final dbHelper = DatabaseHelper.instance;
          await dbHelper.deleteAll();
          showAlert(context);

          // Get.to(BottomNavigationBarPage());
        }
        else{
          Navigator.pop(context);

        }
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
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(color: kPrimaryColor, type: SpinKitWaveType.center));
            });


        final storage = new FlutterSecureStorage();

        Map<String, dynamic> body = {
          "CustomerID": await storage.read(key: "_userID"),
          "OrderType": "APP",
          "OrderDate": "2021-01-28",
          "StatusID": 2,
          "LocationID": 2112,
          "OrderCheckouts": {
            "PaymentMode": 1,
            "AmountPaid": amount,
            "AmountTotal": amount,
            "ServiceCharges": 0,
            "GrandTotal": 0,
            "Tax": 0,
            "CheckoutDate": "2021-01-28",
            "StatusID": 2
          },
          "OrderDetails": items
        };
        String jsonBody = json.encode(body);
        //print(jsonBody);

        final headers = {'Content-Type': 'application/json'};

        http.Response res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/orders/new',
          headers: headers,

          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if(data['description'] == "Your order has been punched successfully."){
          Navigator.pop(context);
          final dbHelper = DatabaseHelper.instance;
          await dbHelper.deleteAll();
          showAlert(context);

          // Get.to(BottomNavigationBarPage());
        }
        else{
          Navigator.pop(context);

        }
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


  void showAlert(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    height: height * 0.45,
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
                                    Icons.done,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'order.success',
                                  style: Theme.of(context).textTheme.headline1,
                                ).tr(),
                                SizedBox(height: 12.0),
                                Text(
                                  'order.subtitlesuccess',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ).tr(),
                                SizedBox(height: 20),
                                RaisedButtonWidget(
                                  title: 'CLOSE',
                                  onPressed: () => Get.offAll(BottomNavigationBarPage())

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
