part of '../pages.dart';

class EditAddressPage extends StatefulWidget {
  final address;

  const EditAddressPage({Key key, @required this.address}) : super(key: key);

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  var _Name = '';
  var _Address = '';
  var _City = '';
  var _Zip = '';
  var _Number = '';

  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _textcontroller;

  LatLng currentPostion;
  bool showMap = false;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController mapController;

  var sendPostion;
  String SendAddress = "";
  @override
  void initState() {
    _getUserLocation();
    _textcontroller =
        new TextEditingController(text: widget.address['Address'].toString());
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
    setState(() {
      currentPostion = LatLng(double.parse(widget.address['Latitude']),
          double.parse(widget.address['Longitude']));

      showMap = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.address);

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
          "CustomerAddressID": widget.address['CustomerAddressID'],
          "Address": SendAddress.toString().length > 1
              ? SendAddress.toString()
              : widget.address['Address'].toString(),
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
                      // hintText: "Search Address",
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
                                    (BuildContext context, StateSetter state) {
                                  return Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
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
                                                    initialValue: widget
                                                        .address['StreetName']
                                                        .toString(),
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
                                                    initialValue: widget
                                                        .address['ContactNo']
                                                        .toString(),
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
                                            SizedBox(height: 25.0),
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
