part of '../pages.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  var address = {'Address': []};
  bool showAddress = false;
  int dateindex;
  var addressSelected;
  bool showBtn = false;
  String _userID = "";
  num amount = 0;
  var items = [];
  String priceGlobal;
  String DeliveryGlobal;
  String TaxGlobal;

  String _LocationID;
  String _UserID;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    setState(() {
      getAddress();
      this._query();
      getGlobal();
    });
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

  getGlobal() async {
    final storage = new FlutterSecureStorage();
    priceGlobal = await storage.read(key: "_Currency");
    _LocationID = await storage.read(key: "_LocationID");
    _UserID = await storage.read(key: "_UserID");

    TaxGlobal = await storage.read(key: "_TaxPercentTaxPercent");
    DeliveryGlobal = await storage.read(key: "_DeliveryCharges");
    setState(() {});
  }

  void _query() async {
    //print('cart');
    final dbHelper = DatabaseHelper.instance;

    var allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      items.add({
        "ItemID": row['id'],
        "ItemName": row['title'],
        "Quantity": row['quantity'],
        "Price": row['price'],
        "Cost": 0,
        "StatusID": 1,
        "OrderModifierDetails": [
          {
            "ModifierID": row['modifierID'],
            "VariantID": 0,
            "ModifierName": row['modifier'],
            "Quantity": 0,
            "Price": row['modifierPrice'],
            "Type": 'Modifier',
            "Cost": 0,
            "StatusID": 1
          },
          {
            "ModifierID": 0,
            "VariantID": row['variantID'],
            "VariantName": row['variant'],
            "Quantity": 0,
            "Price": row['variantPrice'],
            "Type": 'Variant',
            "Cost": 0,
            "StatusID": 1
          }
        ]
      });
      amount += double.parse(row['price']);
      //print(amount);
      //print(row);
      print(items);
    });
  }

  getAddress() async {
    final storage = new FlutterSecureStorage();

    String _userEmail = await storage.read(key: "_userEmail");
    String _userPassword = await storage.read(key: "_userPassword");
    String _userID = await storage.read(key: "_userID");

    if (_userPassword == "") {
      setState(() {
        _userPassword = 'null';
      });
    }
    String url =
        'http://retailapi.airtechsolutions.pk/api/customer/login/${_userID}';

    print(url);
    http.Response res = await http.get(
      url,
    );
    var data = json.decode(res.body.toString());
    //print(data);

    if (data['description'].toString() == "Success") {
      //print(data['customer']['Addresses']);
      address['Address'].addAll(data['customer']['Addresses']);

      //print(address);

      setState(() {
        showAddress = true;
      });
      print(address['Address'].length);
      if (address['Address'].length == 0) {
        print('Yes showBtn');
        setState(() {
          showBtn = true;
        });
      } else {
        setState(() {
          showBtn = false;
        });
        print('No showBtn');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    onClick() async {
      initConnectivity();
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showAddress
                ? Flexible(
                    flex: 9,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            'order.shippingaddress',
                            style: Theme.of(context).textTheme.headline4,
                          ).tr(),
                          SizedBox(height: 20.0),
                          ListView.builder(
                            itemCount: address['Address'].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SideInAnimation(
                                  index,
                                  child: GestureDetector(
                                    // onTap: widget.onPressed,
                                    onTap: () {
                                      setState(() {
                                        dateindex = index;
                                        addressSelected =
                                            address['Address'][index];
                                        print(addressSelected);
                                      });
                                    },
                                    child: Stack(children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(15.0),
                                        margin: EdgeInsets.only(bottom: 15.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: dateindex == index
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).accentColor,
                                            width:
                                                dateindex == index ? 2.0 : 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                showAddress
                                                    ? address['Address'][index]
                                                        ['Address']
                                                    : '...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                            SizedBox(height: 8.0),
                                            Text(
                                                showAddress
                                                    ? address['Address'][index]
                                                        ['StreetName']
                                                    : '...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 5.0,
                                        bottom: 0.0,
                                        child: Row(
                                          children: [
                                            ClipOval(
                                              child: Material(
                                                color:
                                                    kPrimaryColor, // button color
                                                child: InkWell(
                                                  splashColor: Colors
                                                      .red, // inkwell color
                                                  child: SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.white,
                                                          size: 18)),
                                                  onTap: () {
                                                    Get.to(EditAddressPage(
                                                        address:
                                                            address['Address']
                                                                [index]));
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5.0),
                                            ClipOval(
                                              child: Material(
                                                color:
                                                    kErrorLightColor, // button color
                                                child: InkWell(
                                                  splashColor: Colors
                                                      .red, // inkwell color
                                                  child: SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.white,
                                                          size: 18)),
                                                  onTap: () async {
                                                    print(address['Address']);
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Center(
                                                              child: const SpinKitWave(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  type: SpinKitWaveType
                                                                      .center));
                                                        });
                                                    Map<String, dynamic> body =
                                                        {
                                                      "CustomerAddressID": address[
                                                              'Address'][0]
                                                          ['CustomerAddressID'],
                                                      "Address": "delete",
                                                      "NickName": "delete",
                                                      "Latitude": "delete",
                                                      "Longitude": "delete",
                                                      "StatusID": 3,
                                                      "StreetName": "delete",
                                                      "CustomerID":
                                                          address['Address'][0]
                                                              ['CustomerID'],
                                                      "Country": "delete",
                                                      "ContactNo": "delete"
                                                    };
                                                    String jsonBody =
                                                        json.encode(body);
                                                    final headers = {
                                                      'Content-Type':
                                                          'application/json'
                                                    };

                                                    print(jsonBody);
                                                    http.Response res =
                                                        await http.post(
                                                      'http://retailapi.airtechsolutions.pk/api/customer/address/addorupdate',
                                                      headers: headers,
                                                      body: jsonBody,
                                                    );
                                                    var data = json.decode(
                                                        res.body.toString());
                                                    print(data);
                                                    if (data['description'] ==
                                                        "Your addresses updated successfully.") {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        showBtn = false;
                                                        address['Address']
                                                            .clear();
                                                      });

                                                      getAddress();
                                                      print('hogya delete');
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 25.0),
                        ],
                      ),
                    ),
                  )
                : Container(),
            showBtn
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/undraw_Directions_re_kjxs.png',
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          'No Address Available',
                          style: Theme.of(context).textTheme.headline1,
                        ).tr(),
                        SizedBox(height: 15.0),
                        Text(
                          'Please add address so we can deliver. Happy Shopping  :)',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ).tr(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                      ],
                    ),
                  )
                : Container(),
            showBtn
                ? Container()
                : Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 15.0),
                      child: FadeInAnimation(
                        2,
                        child: RaisedButtonWidget(
                          title: 'Confirm To Proceed',
                          onPressed: () {
                            onClick();
                          },
                        ),
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
                  child: const SpinKitWave(
                      color: kPrimaryColor, type: SpinKitWaveType.center));
            });

        if (dateindex != null) {
          final storage = new FlutterSecureStorage();

          double Tax = int.parse(TaxGlobal) / 100 * amount;

          Map<String, dynamic> body = {
            "CustomerID": await storage.read(key: "_userID"),
            "OrderType": "APP",
            "OrderDate": "2021-01-28",
            "StatusID": 2,
            "LocationID": _LocationID,
            "UserID": _UserID,
            "CustomerOrders": {
              "Name": addressSelected['NickName'],
              "Email": "notavailable@mail.com",
              "Mobile": addressSelected['ContactNo'],
              "Description": "",
              "AddressNickName": addressSelected['StreetName'],
              "AddressType": "Home",
              "Address": addressSelected['Address'],
              "Longitude": "",
              "Latitude": "",
              "LocationURL": ""
            },
            "OrderCheckouts": {
              "PaymentMode": 1,
              "AmountPaid": amount,
              "AmountTotal": amount + int.parse(DeliveryGlobal) + Tax,
              "ServiceCharges": int.parse(DeliveryGlobal),
              "GrandTotal": 0,
              "Tax": Tax,
              "CheckoutDate": "2021-01-28",
              "StatusID": 2
            },
            "OrderDetails": items
          };
          String jsonBody = json.encode(body);
          print(jsonBody);

          final headers = {'Content-Type': 'application/json'};

          http.Response res = await http.post(
            'http://retailapi.airtechsolutions.pk/api/orders/new',
            headers: headers,
            body: jsonBody,
          );
          var data = json.decode(res.body.toString());
          print(data);

          if (data['description'] ==
              "Your order has been punched successfully.") {
            Navigator.pop(context);
            final dbHelper = DatabaseHelper.instance;
            await dbHelper.deleteAll();
            showAlert(context, data['OrderID']);

            // Get.to(BottomNavigationBarPage());
          } else {
            Navigator.pop(context);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Address not selected. ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18.0),
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
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'No Internet Access',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ).tr(),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'Your wifi have no internet access',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ).tr(),
                                    SizedBox(height: 20),
                                    RaisedButtonWidget(
                                        title: 'Change',
                                        onPressed: () =>
                                            {AppSettings.openWIFISettings()}),
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
                  child: const SpinKitWave(
                      color: kPrimaryColor, type: SpinKitWaveType.center));
            });

        if (dateindex != null) {
          final storage = new FlutterSecureStorage();

          double Tax = int.parse(TaxGlobal) / 100 * amount;

          Map<String, dynamic> body = {
            "CustomerID": await storage.read(key: "_userID"),
            "OrderType": "APP",
            "OrderDate": "2021-01-28",
            "StatusID": 2,
            "LocationID": _LocationID,
            "UserID": _UserID,
            "CustomerOrders": {
              "Name": addressSelected['NickName'],
              "Email": "notavailable@mail.com",
              "Mobile": addressSelected['ContactNo'],
              "Description": "",
              "AddressNickName": addressSelected['StreetName'],
              "AddressType": "Home",
              "Address": addressSelected['Address'],
              "Longitude": "",
              "Latitude": "",
              "LocationURL": ""
            },
            "OrderCheckouts": {
              "PaymentMode": 1,
              "AmountPaid": amount,
              "AmountTotal": amount + int.parse(DeliveryGlobal) + Tax,
              "ServiceCharges": int.parse(DeliveryGlobal),
              "GrandTotal": 0,
              "Tax": Tax,
              "CheckoutDate": "2021-01-28",
              "StatusID": 2
            },
            "OrderDetails": items
          };
          String jsonBody = json.encode(body);
          print(jsonBody);

          final headers = {'Content-Type': 'application/json'};

          http.Response res = await http.post(
            'http://retailapi.airtechsolutions.pk/api/orders/new',
            headers: headers,
            body: jsonBody,
          );
          var data = json.decode(res.body.toString());
          print(data);

          if (data['description'] ==
              "Your order has been punched successfully.") {
            Navigator.pop(context);
            final dbHelper = DatabaseHelper.instance;
            await dbHelper.deleteAll();
            showAlert(context, data['OrderID']);

            // Get.to(BottomNavigationBarPage());
          } else {
            Navigator.pop(context);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Address not selected. ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18.0),
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
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'No Internet Access',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ).tr(),
                                    SizedBox(height: 12.0),
                                    Text(
                                      'Your data have no internet access',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ).tr(),
                                    SizedBox(height: 20),
                                    RaisedButtonWidget(
                                        title: 'Change',
                                        onPressed: () =>
                                            {AppSettings.openDateSettings()}),
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
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 18.0),
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
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'No Internet Connection',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ).tr(),
                                  SizedBox(height: 12.0),
                                  Text(
                                    'Your wifi or cellular data is not open.',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    textAlign: TextAlign.center,
                                  ).tr(),
                                  SizedBox(height: 20),
                                  RaisedButtonWidget(
                                      title: 'Open',
                                      onPressed: () =>
                                          {AppSettings.openWIFISettings()}),
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

  void navigateToPaymentPage() {
    Get.to(PaymentPage());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'order.checkout',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.to(AddAddressPage());
          },
        ),
      ],
    );
  }

  void showAlert(BuildContext context, orderID) {
    print(orderID);
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                    height: height * 0.56,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'order.success',
                                  style: Theme.of(context).textTheme.headline1,
                                ).tr(),
                                SizedBox(height: 20),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, //Center Row contents horizontally,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, //Center Row contents vertically,
                                    children: [
                                      Text(
                                        'Order # ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        textAlign: TextAlign.center,
                                      ).tr(),
                                      Text(
                                        '${orderID}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ).tr(),
                                    ]),
                                SizedBox(height: 12.0),
                                Text(
                                  'order.subtitlesuccess',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ).tr(),
                                SizedBox(height: 20),
                                RaisedButtonWidget(
                                    title: 'CLOSE',
                                    onPressed: () =>
                                        Get.offAll(BottomNavigationBarPage())),
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
