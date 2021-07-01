part of '../pages.dart';

class ProfileAddressPage extends StatefulWidget {
  @override
  _ProfileAddressPageState createState() => _ProfileAddressPageState();
}

class _ProfileAddressPageState extends State<ProfileAddressPage> {
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

  @override
  void initState() {
    setState(() {
      getAddress();
      getGlobal();
    });
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
                              return SideInAnimation(
                                index,
                                child: GestureDetector(
                                  // onTap: widget.onPressed,
                                  onTap: () {
                                    setState(() {
                                      addressSelected =
                                          address['Address'][index];
                                      print(addressSelected);
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15.0),
                                    margin: EdgeInsets.only(bottom: 15.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0,
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
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: GoogleMap(
                                            markers: _markers,
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              _controller.complete(controller);
                                              setState(() {
                                                _markers.add(Marker(
                                                    markerId: MarkerId('1'),
                                                    position: LatLng(
                                                        double.parse(
                                                            address['Address']
                                                                    [index]
                                                                ['Latitude']),
                                                        double.parse(address[
                                                                    'Address']
                                                                [index]
                                                            ['Longitude']))));
                                              });
                                            },
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: LatLng(
                                                        double.parse(
                                                            address['Address']
                                                                    [index]
                                                                ['Latitude']),
                                                        double.parse(
                                                            address['Address']
                                                                    [index]
                                                                ['Longitude'])),
                                                    zoom: 16.0,
                                                    tilt: 50),
                                            zoomControlsEnabled: false,
                                            zoomGesturesEnabled: false,
                                            compassEnabled: false,
                                            scrollGesturesEnabled: false,
                                            rotateGesturesEnabled: false,
                                          ),
                                        ),
                                        Text(
                                            showAddress
                                                ? address['Address'][index]
                                                    ['NickName']
                                                : '...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1),
                                        SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit_outlined),
                                              onPressed: () {
                                                Get.to(EditAddressPage(
                                                    address: address['Address']
                                                        [index]));
                                              },
                                            ),
                                            SizedBox(width: 15.0),
                                            IconButton(
                                              icon: Icon(Icons.delete_outline),
                                              onPressed: () {
                                                // showDeleteConfirmation(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
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
          ],
        ),
      ),
    );
  }

  void navigateToPaymentPage() {
    Get.to(PaymentPage());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Addresses',
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
}
