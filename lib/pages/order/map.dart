part of '../pages.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State<AddAddressPage> createState() => AddAddressPageState();
}

class AddAddressPageState extends State<AddAddressPage> {
  Completer<GoogleMapController> _controller = Completer();
  final _textcontroller = TextEditingController();
  int addressType = 0;
  LatLng currentPostion;
  bool showMap = false;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;
  final _formKey = GlobalKey<FormState>();
  var _Name = '';
  var _Address = '';
  var _City = '';
  var _Zip = '';
  var _Number = '';
  var sendPostion;
  String SendAddress = "";
  @override
  void initState() {
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    mapController = controller;
    //
    // mapController.setMapStyle(
    //     '[{"featureType": "all","stylers": [{ "color": "#C0C0C0" }]},{"featureType": "road.arterial","elementType": "geometry","stylers": [{ "color": "#CCFFFF" }]},{"featureType": "landscape","elementType": "labels","stylers": [{ "visibility": "off" }]}]');

    if (currentPostion != null) {
      MarkerId markerId = MarkerId(_markerIdVal());
      LatLng position = currentPostion;
      print('current Location : ${currentPostion}');
      sendPostion = currentPostion;
      print(sendPostion.latitude);
      print(sendPostion.longitude);

      Marker marker = Marker(
        markerId: markerId,
        position: position,
        draggable: false,
        // ignore: deprecated_member_use
        icon: BitmapDescriptor.fromAsset("assets/images/mark-icon.png"),
      );
      setState(() {
        _markers[markerId] = marker;
      });

      Future.delayed(Duration(seconds: 1), () async {
        GoogleMapController controller = await _mapController.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: position, zoom: 17.0, tilt: 50),
          ),
        );
      });
    }
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);

      showMap = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<http.Response> _trySubmit() async {
      final isValid = _formKey.currentState.validate();
      final _textcontroller = TextEditingController();

      if (isValid) {
        _formKey.currentState.save();

        //print(_Name.trim());
        //print(_Address.trim());
        //print(_City.trim());
        //print(_Zip.trim());
        //print(_Number.trim());
        final storage = new FlutterSecureStorage();

        String _userID = await storage.read(key: "_userID");
        //print(_userID);

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                  child: const SpinKitWave(
                      color: kPrimaryColor, type: SpinKitWaveType.center));
            });

        Map<String, dynamic> body = {
          "CustomerAddressID": 0,
          "Address": SendAddress.toString(),
          "NickName": _Name.trim().toString(),
          "Latitude": sendPostion.latitude,
          "Longitude": sendPostion.longitude,
          "StatusID": 1,
          "StreetName": _Address.trim().toString(),
          "CustomerID": int.parse(_userID),
          "Country": _City.trim().toString(),
          "ContactNo": _Number.trim().toString()
        };
        String jsonBody = json.encode(body);
        final headers = {'Content-Type': 'application/json'};

        print(jsonBody);
        http.Response res = await http.post(
          'http://retailapi.airtechsolutions.pk/api/customer/address/addorupdate',
          headers: headers,
          body: jsonBody,
        );
        var data = json.decode(res.body.toString());
        //print(data);

        if (data['description'] == "Your addresses updated successfully.") {
          Navigator.pop(context);
          Get.to(AddressPage());
        } else {
          Navigator.pop(context);
        }
      }
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Location',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: showMap
          ? Stack(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  markers: Set<Marker>.of(_markers.values),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: currentPostion, zoom: 16.0, tilt: 50),
                  myLocationEnabled: true,
                  onCameraMove: (CameraPosition position) {
                    setState((){
                      SendAddress = 'No Name | No Address';

                    });
                    if (_markers.length > 0) {
                      print('current Location : ${position.target}');
                      // sendPostion = LatLng(latitude, longitude)
                      sendPostion = position.target;
                      print(sendPostion.latitude);
                      print(sendPostion.longitude);
                      MarkerId markerId = MarkerId(_markerIdVal());
                      Marker marker = _markers[markerId];
                      Marker updatedMarker = marker.copyWith(
                        positionParam: position.target,
                      );

                      setState(() {
                        _markers[markerId] = updatedMarker;
                      });
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _textcontroller,
                    onTap: () async {
                      // generate a new token here
                      final sessionToken = Uuid().v4();
                      final Suggestion result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      // This will change the text displayed in the TextField
                      if (result != null) {
                        setState(() {
                          _textcontroller.text = result.description;
                          SendAddress = result.description;
                        });
                      }
                    },
                    // with some styling
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.home,
                          color: kPrimaryColor,
                        ),
                      ),
                      hintText: "Search Address",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: FadeInAnimation(
                      6,
                      child: RaisedButtonWidget(
                        title: 'NEXT',
                        onPressed: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(23.0),
                                      topRight: const Radius.circular(23.0))),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.53,
                                    child: Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SideInAnimation(
                                                  2,
                                                  child: Text(
                                                          'product.streetaddress',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline4)
                                                      .tr(),
                                                ),
                                                SizedBox(height: 15.0),
                                                SideInAnimation(
                                                  2,
                                                  child: TextFormField(
                                                    key: ValueKey('address'),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Address.';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      _Address = value;
                                                    },
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    autocorrect: false,
                                                    decoration: InputDecoration(
                                                      hintText: tr(
                                                          'Ex House no, Street no, Near By'),
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle2,
                                                      prefixIcon: Icon(
                                                          FlutterIcons
                                                              .location_pin_sli),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor
                                                              .withOpacity(.4),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                              )),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SideInAnimation(
                                                  5,
                                                  child: Text(
                                                    'product.phone',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4,
                                                  ).tr(),
                                                ),
                                                SizedBox(height: 15.0),
                                                SideInAnimation(
                                                  5,
                                                  child: TextFormField(
                                                    key: ValueKey('number'),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Number.';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      _Number = value;
                                                    },
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    obscureText: false,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                    autocorrect: false,
                                                    decoration: InputDecoration(
                                                      hintText: tr(
                                                          'product.hinttextphone'),
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .subtitle2,
                                                      prefixIcon: Icon(
                                                          FlutterIcons
                                                              .phone_fea),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentColor
                                                              .withOpacity(.4),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                              )),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.0),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        addressType = 0;
                                                      });
                                                    },
                                                    child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        margin: const EdgeInsets
                                                            .all(15.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            border: Border.all(
                                                                color: addressType ==
                                                                        0
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey)),
                                                        child: Center(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                                Icons
                                                                    .home_outlined,
                                                                color: addressType ==
                                                                        0
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey,
                                                                size: 16),
                                                            SizedBox(width: 2),
                                                            Text(
                                                              'Home',
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: addressType ==
                                                                        0
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ))),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        addressType = 1;
                                                      });
                                                    },
                                                    child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        margin: const EdgeInsets
                                                            .all(15.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            border: Border.all(
                                                                color: addressType ==
                                                                        1
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                                Icons
                                                                    .next_week_outlined,
                                                                color: addressType ==
                                                                        1
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey,
                                                                size: 16),
                                                            SizedBox(width: 2),
                                                            Text(
                                                              'Work',
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: addressType ==
                                                                        1
                                                                    ? kPrimaryColor
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          addressType = 2;
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: 80,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              border: Border.all(
                                                                  color: addressType ==
                                                                          2
                                                                      ? kPrimaryColor
                                                                      : Colors
                                                                          .grey)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: addressType ==
                                                                          2
                                                                      ? kPrimaryColor
                                                                      : Colors
                                                                          .grey,
                                                                  size: 16),
                                                              SizedBox(
                                                                  width: 2),
                                                              Text(
                                                                'Other',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: addressType ==
                                                                          2
                                                                      ? kPrimaryColor
                                                                      : Colors
                                                                          .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ))),
                                                ]),
                                            FadeInAnimation(
                                              6,
                                              child: RaisedButtonWidget(
                                                title: 'product.done',
                                                onPressed: () {
                                                  _trySubmit();
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 25.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              });
                        },
                      ),
                    ),
                  ))
            ])
          : Center(
              child: SpinKitWave(
                  color: kPrimaryColor, type: SpinKitWaveType.center)),
    );
  }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}
