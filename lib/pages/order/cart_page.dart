part of '../pages.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  num amount = 0;
  bool checkLogin = false;
  bool showCart = false;
  String PaymentText = 'Cash on Delivery';
  var allRows;
  var items = {'Items': []};
  String priceGlobal;
  String DeliveryGlobal;
  String TaxGlobal;
  double Tax;
  double Totalamount;
  bool appliedCoupon = true;

  TextEditingController couponController = new TextEditingController();

  void navigateToAddressPage() {
    Get.to(AddressPage());
  }

  final List<String> paymentOption = [
    'Cash on Delivery',
    'Bank Transfer',
  ];

  @override
  void initState() {
    this._query();
  }

  checkCoupon() {
    print(couponController.text);
    print(appliedCoupon);
    if (appliedCoupon) {
      if (couponController.text == "coupon10") {
        var discountvalue = 10 / 100 * amount;
        print(discountvalue);
        amount = amount - discountvalue;
        Tax = int.parse(TaxGlobal) / 100 * amount;
        print(Tax);
        Totalamount = amount + Tax + int.parse(DeliveryGlobal);
        print(Totalamount);
        appliedCoupon = false;
        Fluttertoast.showToast(
            msg: "Coupon applied.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      } else if (couponController.text == "coupon20") {
        var discountvalue = 20 / 100 * amount;
        print(discountvalue);
        amount = amount - discountvalue;
        Tax = int.parse(TaxGlobal) / 100 * amount;
        print(Tax);
        Totalamount = amount + Tax + int.parse(DeliveryGlobal);
        print(Totalamount);
        appliedCoupon = false;
        Fluttertoast.showToast(
            msg: "Coupon applied.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      } else if (couponController.text == "coupondeduct250") {
        var discountvalue = 250;
        print(discountvalue);
        amount = amount - discountvalue;
        Tax = int.parse(TaxGlobal) / 100 * amount;
        print(Tax);
        Totalamount = amount + Tax + int.parse(DeliveryGlobal);
        print(Totalamount);
        appliedCoupon = false;
        Fluttertoast.showToast(
            msg: "Coupon applied.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      } else {
        Fluttertoast.showToast(
            msg: "Invalid coupon.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      print('coupon already applied');
      Fluttertoast.showToast(
          msg: "You can use one coupon only.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _query() async {
    amount = 0;
    final storage = new FlutterSecureStorage();

    priceGlobal = await storage.read(key: "_Currency");

    TaxGlobal = await storage.read(key: "_TaxPercentTaxPercent");
    print('asda');
    print(TaxGlobal);
    DeliveryGlobal = await storage.read(key: "_DeliveryCharges");
    //print('cart');
    final dbHelper = DatabaseHelper.instance;

    allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      amount += row['quantity'] * double.parse(row['price']);
      items['Items'].add(row);
      print(amount);
      print(row);
    });
    print(allRows.length);
    if (allRows.length == 0) {
      showCart = false;
    } else {
      showCart = true;
      print('adssadadsa');
      print(TaxGlobal);
      Tax = int.parse(TaxGlobal) / 100 * amount;
      print(Tax);
      Totalamount = amount + Tax + int.parse(DeliveryGlobal);
      print(Totalamount);
      setState(() {});
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildListCartCard(),
              SizedBox(height: 20.0),
              showCart ? buildCoupunBox(context) : Container(),
              SizedBox(height: 20.0),

              appliedCoupon ? Container() : Center(
                child: FadeInAnimation(
                  4,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border:
                      Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Applied Coupon',
                              style:
                              Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                                '${couponController.text}',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              Center(
                child: FadeInAnimation(
                  4,
                  child: showCart
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: Theme.of(context).accentColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr('order.items'),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                      '$priceGlobal ${amount.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tax',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)
                                      .tr(),
                                  Text('$priceGlobal ${Tax.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('order.shipping',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2)
                                      .tr(),
                                  Text('$priceGlobal ${DeliveryGlobal}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ],
                              ),
                              SizedBox(height: 12.0),
                              Divider(
                                color: Theme.of(context).accentColor,
                                thickness: 1.0,
                              ),
                              SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'order.totalprice',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ).tr(),
                                  Text(
                                    '$priceGlobal ${Totalamount.toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/cart_empty.png',
                                width: MediaQuery.of(context).size.width / 2,
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Bag is Empty',
                                style: Theme.of(context).textTheme.headline1,
                              ).tr(),
                              SizedBox(height: 15.0),
                              Text(
                                'Please add products in your bag. Happy Shopping  :)',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1,
                              ).tr(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 18.0),
              showCart
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                      ),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                IconButton(
                                    icon: Icon(Icons.money_outlined,
                                        color: kPrimaryColor),
                                    onPressed: () {}),
                                Text(PaymentText),
                              ]),
                              GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              padding: EdgeInsets.all(8),
                                              height: 275,
                                              alignment: Alignment.center,
                                              child: Column(children: [
                                                GestureDetector(
                                                    child: Row(children: [
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons
                                                                  .money_outlined,
                                                              color:
                                                                  kPrimaryColor)),
                                                      Text('Cash On Delivery')
                                                    ]),
                                                    onTap: () {
                                                      setState(() {
                                                        PaymentText =
                                                            'Cash On Delivery';
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                GestureDetector(
                                                    child: Row(children: [
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.food_bank,
                                                              color:
                                                                  kPrimaryColor)),
                                                      Text('Bank Transfer')
                                                    ]),
                                                    onTap: () {
                                                      setState(() {
                                                        PaymentText =
                                                            'Bank Transfer';
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                GestureDetector(
                                                    child: Row(children: [
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons
                                                                  .monetization_on,
                                                              color:
                                                                  kPrimaryColor)),
                                                      Text('Benefit Pay')
                                                    ]),
                                                    onTap: () {
                                                      setState(() {
                                                        PaymentText =
                                                            'Benefit Pay';
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                GestureDetector(
                                                    child: Row(children: [
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons
                                                                  .card_membership_outlined,
                                                              color:
                                                                  kPrimaryColor)),
                                                      Text('Credit Card')
                                                    ]),
                                                    onTap: () {
                                                      setState(() {
                                                        PaymentText =
                                                            'Credit Card';
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                              ]));
                                        });
                                  },
                                  child: Text('CHANGE',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold)))
                            ]),
                      ))
                  : Container(),
              SizedBox(height: 20.0),
              showCart
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: TextField(
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: new BorderSide(color: kPrimaryColor)),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: new BorderSide(color: kPrimaryColor)),
                          focusedBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: new BorderSide(color: kPrimaryColor)),
                          hintText: 'Special instruction',
                        ),

                        keyboardType: TextInputType.multiline,
                        minLines: 1, //Normal textInputField will be displayed
                        maxLines:
                            5, // when user presses enter it will adapt to it
                      ),
                    )
                  : Container(),
              SizedBox(height: 20.0),
              showCart ? buildCheckoutButton() : Container(),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  FadeInAnimation buildCheckoutButton() {
    return FadeInAnimation(
      5,
      child: RaisedButtonWidget(
        title: 'order.checkout',
        onPressed: () async {
          final storage = new FlutterSecureStorage();

          String imi = await storage.read(key: "imei");
          //print(imi);

          if (imi == "loginhuavaha") {
            navigateToAddressPage();
          } else {
            Get.to(LoginKro());
          }
        },
      ),
    );
  }

  FadeInAnimation buildPriceBox(BuildContext context) {
    return FadeInAnimation(
      4,
      child: showCart
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Theme.of(context).accentColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('order.items') + ' (3)',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(amount.toString(),
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('order.shipping',
                              style: Theme.of(context).textTheme.subtitle2)
                          .tr(),
                      Text('0', style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                    color: Theme.of(context).accentColor,
                    thickness: 1.0,
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'order.totalprice',
                        style: Theme.of(context).textTheme.subtitle2,
                      ).tr(),
                      Text(
                        amount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/cart_empty.png',
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Bag is Empty',
                    style: Theme.of(context).textTheme.headline1,
                  ).tr(),
                  SizedBox(height: 15.0),
                  Text(
                    'Please add products in your bag. Happy Shopping  :)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ],
              ),
            ),
    );
  }

  FadeInAnimation buildCoupunBox(BuildContext context) {
    return FadeInAnimation(
      2,
      child: Container(
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  controller: couponController,
                  cursorColor: Theme.of(context).primaryColor,
                  style: Theme.of(context).textTheme.subtitle1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: tr('order.entercouponcode'),
                    hintStyle: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 85.0,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Text(
                  'order.apply',
                  style: Theme.of(context).textTheme.button,
                ).tr(),
                onPressed: () {
                  checkCoupon();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListCartCard() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items['Items'].length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(items['Items'][index]['image'],
                            width: 100, height: 100)),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    items['Items'][index]['title'],
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        //print('delete');
                                        final dbHelper =
                                            DatabaseHelper.instance;

                                        final id =
                                            await dbHelper.queryRowCount();
                                        //print(id);
                                        final rowsDeleted =
                                            await dbHelper.delete(id,
                                                items['Items'][index]['uId']);
                                        print(
                                            'deleted $rowsDeleted row(s): row $id');

                                        setState(() {
                                          items['Items'].clear();
                                          _query();
                                        });
                                      },
                                      child: Icon(
                                        FlutterIcons.delete_outline_mco,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    items['Items'][index]['variant'] == ''
                                        ? ''
                                        : '${items['Items'][index]['variant']} | ${items['Items'][index]['modifier']}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Row(
                                  children: [],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '$priceGlobal ${items['Items'][index]['price']}',
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.5),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 3.0),
                                      GestureDetector(
                                        onTap: () async {
                                          //print('delete');
                                          if (items['Items'][index]
                                                  ['quantity'] <=
                                              1) {
                                          } else {
                                            final dbHelper =
                                                DatabaseHelper.instance;

                                            final id =
                                                await dbHelper.queryRowCount();

                                            final rowsDeleted =
                                                await dbHelper.updateCustomer(
                                                    id,
                                                    items['Items'][index]
                                                        ['uId'],
                                                    items['Items'][index]
                                                            ['quantity'] -
                                                        1);
                                            print(
                                                'deleted $rowsDeleted row(s): row $id');
                                            setState(() {
                                              items['Items'].clear();
                                              _query();
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      ),
                                      SizedBox(width: 3.0),
                                      CircleAvatar(
                                        radius: 15.0,
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        child: Text(
                                          items['Items'][index]['quantity']
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),
                                      SizedBox(width: 3.0),
                                      GestureDetector(
                                        onTap: () async {
                                          //print('delete');
                                          final dbHelper =
                                              DatabaseHelper.instance;

                                          final id =
                                              await dbHelper.queryRowCount();

                                          final rowsDeleted =
                                              await dbHelper.updateCustomer(
                                                  id,
                                                  items['Items'][index]['uId'],
                                                  items['Items'][index]
                                                          ['quantity'] +
                                                      1);
                                          print(
                                              'deleted $rowsDeleted row(s): row $id');
                                          setState(() {
                                            items['Items'].clear();
                                            _query();
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                      ),
                                      SizedBox(width: 3.0),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'order.mybag',
        style: Theme.of(context).textTheme.headline4,
      ).tr(),
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.search),
      //     onPressed: () {
      //       showSearch(context: context, delegate: Search());
      //     },
      //   ),
      // ],
    );
  }
}
