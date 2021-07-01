part of '../pages.dart';

class ProductDetailPage2 extends StatefulWidget {
  const ProductDetailPage2({Key key, @required this.product}) : super(key: key);
  final product;

  @override
  _ProductDetailPage2State createState() => _ProductDetailPage2State();
}

class _ProductDetailPage2State extends State<ProductDetailPage2> {
  int selectedImage = 0;

  int dateindex;
  int colorindex;
  int id;
  String title;
  String image;
  String price;
  String color;
  String sizeselect;
  bool size;
  bool colors;
  String selectedModifier = "";
  String selectedModifierID = "";
  String selectedModifierType = "";
  String selectedModifierPrice = "";

  String selectedVariant = "";
  String selectedVariantID = "";
  String selectedVariantType = "";
  String selectedVariantPrice = "";

  var allRows;
  var items = {'Items': []};
  int cartNumber = 0;
  String priceGlobal;
  String _DeliveryCharges;
  String _TaxPercentTaxPercent;
  double totalSendPrice;
  double totalModPrice = 0.0;
  double totalVarPrice = 0.0;

  @override
  void initState() {
    totalSendPrice = widget.product['Price'];
    getGlobal();
    setState(() {
      getCartNumber();
    });
  }

  getGlobal() async {
    final storage = new FlutterSecureStorage();
    priceGlobal = await storage.read(key: "_Currency");

    _TaxPercentTaxPercent = await storage.read(key: "_TaxPercentTaxPercent");
    _DeliveryCharges = await storage.read(key: "_DeliveryCharges");
    setState(() {});
  }

  getCartNumber() async {
    final dbHelper = DatabaseHelper.instance;

    allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      //print(amount);
      //print(row);
    });
    // print(allRows.length);

    setState(() {
      cartNumber = allRows.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('//print kara ');
    print(widget.product);
    // print(widget.product['SubCategoryID']);

    // print(searchArray.searchArrayData);
    var data = searchArray.searchArrayData
        .where((i) => i['SubCategoryID'] == widget.product['SubCategoryID'])
        .toList();
    // print(data);
    // print(data.length);

    double stackWidth = MediaQuery.of(context).size.width;
    double stackHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCarousel(context),
              SizedBox(height: 15.0),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleAndFavorite(context),
                    SizedBox(height: 12.0),
                    // buildRating(),
                    // SizedBox(height: 12.0),
                    buildPrice(context),
                    SizedBox(height: 12.0),
                    buildDescriptionHeading(context),
                    buildDescriptionBody(context),
                    SizedBox(height: 15.0),
                    // buildRatingHeading(context),
                    // SizedBox(height: 12.0),
                    // buildRatingIcon(context),
                    // SizedBox(height: 15.0),
                    // FadeInAnimation(9, child: ReviewCardWidget()),
                    // buildOtherHeading(context),
                    // buildOtherProducts(),
                    SizedBox(height: 10.0),
                    SideInAnimation(
                      2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 15.0),
                        child: Text(
                          'category.morebestproduct',
                          style: Theme.of(context).textTheme.headline4,
                        ).tr(),
                      ),
                    ),
                    SizedBox(height: 10.0),

                    Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length.clamp(0, 6),
                          itemBuilder: (context, index) {
                            var product = data[index];
                            return FadeInAnimation(
                              index,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: ProductCard2(
                                    product: product,
                                    isHorizontalList: false,
                                  )),
                            );
                          },
                        )),
                    // SizedBox(height: 100.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(FlutterIcons.shopping_cart_fea),
        elevation: 8,
        onPressed: () async {
          var cart = Cart();
          cart.uId = new Random().nextInt(10000);
          cart.id = widget.product['ID'];
          cart.title = widget.product['Name'];
          cart.image = widget.product['Image'];
          cart.price = totalSendPrice.toString();
          cart.variant = selectedVariant;
          cart.modifier = selectedModifier;
          cart.modifierID = int.tryParse(selectedModifierID) ?? 0;
          cart.modifierPrice = selectedModifierPrice;
          cart.modifierType = selectedModifierType;

          cart.variantID = int.tryParse(selectedVariantID) ?? 0;
          cart.variantPrice = selectedVariantPrice;
          cart.variantType = selectedVariantType;

          cart.quantity = 1;
          print('cart data');

          print(cart.modifier);

          final dbHelper = DatabaseHelper.instance;

          final id = await dbHelper.insert(cart);
          // Model.createCustomer(map);
          Fluttertoast.showToast(
              msg: "Product added to cart.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kPrimaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            getCartNumber();
          });
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: new Stack(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Get.to(CartPage());
                  },
                  child: new Icon(Icons.shopping_cart_outlined)),
              new Positioned(
                right: 0,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: new Text(
                    cartNumber.toString(),
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  VerticalList buildOtherProducts() => VerticalList(itemCount: productList);

  Padding buildOtherHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
      child: Text(
        'product.youmightalsolike',
        style: Theme.of(context).textTheme.headline1,
      ).tr(),
    );
  }
  //
  // FadeInAnimation buildRatingIcon(BuildContext context) {
  //   return FadeInAnimation(
  //     8,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //       child: Row(
  //         children: [
  //           SmoothStarRating(
  //             color: kYellowColor,
  //             size: 25.0,
  //             isReadOnly: true,
  //             spacing: 5.0,
  //             starCount: 5,
  //             rating: 3.5,
  //             allowHalfRating: true,
  //             borderColor: kGreyColor,
  //           ),
  //           SizedBox(width: 12.0),
  //           RichText(
  //             text: TextSpan(
  //               children: [
  //                 TextSpan(
  //                   text: '4.5  ',
  //                   style: Theme.of(context).textTheme.subtitle2,
  //                 ),
  //                 TextSpan(
  //                   text: '(5) ' + tr("product.reviews"),
  //                   style: Theme.of(context).textTheme.subtitle2,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // FadeInAnimation buildRatingHeading(BuildContext context) {
  //   return FadeInAnimation(
  //     7,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 18.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'product.reviews',
  //             style: Theme.of(context).textTheme.headline3,
  //           ).tr(),
  //           GestureDetector(
  //             onTap: () {
  //               Get.to(ReviewsPage());
  //             },
  //             child: Text(
  //               'product.seemore',
  //               style: Theme.of(context).textTheme.subtitle2,
  //             ).tr(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  FadeInAnimation buildDescriptionBody(BuildContext context) {
    return FadeInAnimation(
      6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
        child: ReadMoreText(
          widget.product['Description'] != null
              ? widget.product['Description']
              : 'Not Available...',
          trimLines: 4,
          colorClickableText: Theme.of(context).primaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: '\n' + tr("product.showmore"),
          trimExpandedText: '\n' + tr("product.showless"),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }

  SideInAnimation buildDescriptionHeading(BuildContext context) {
    return SideInAnimation(
      5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'product.desc',
          style: Theme.of(context).textTheme.headline3,
        ).tr(),
      ),
    );
  }

  SideInAnimation buildPrice(BuildContext context) {
    double stackWidth = MediaQuery.of(context).size.width;
    double stackHeight = MediaQuery.of(context).size.height;
    List<Widget> textWidgetList = List<Widget>();

    if (widget.product['Modifiers'].length == 0) {
      print('no');

      size = false;
    } else {
      print('yes');
      size = true;
      for (int i = 0; i < widget.product['Modifiers'].length; i++) {
        textWidgetList.add(
          GestureDetector(
              onTap: () {
                totalModPrice = 0.0;

                setState(() {
                  dateindex = i;
                  //print(dateindex);
                  colorindex = null;
                  selectedModifier = widget.product['Modifiers'][i]['Name'];
                  selectedModifierID =
                      widget.product['Modifiers'][i]['ID'].toString();
                  selectedModifierType =
                      widget.product['Modifiers'][i]['Type'].toString();
                  selectedModifierPrice =
                      widget.product['Modifiers'][i]['Price'].toString();

                  print(totalModPrice);
                  print(totalVarPrice);
                  totalModPrice = widget.product['Price'] +
                      widget.product['Modifiers'][i]['Price'];
                  print(totalModPrice);

                  totalSendPrice = totalModPrice;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  // width: stackWidth * 0.15,
                  height: stackWidth * 0.13,
                  decoration: BoxDecoration(
                      color: dateindex == i ? kPrimaryColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(color: kPrimaryColor)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        widget.product['Modifiers'][i]['Name'],
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            color:
                                dateindex == i ? Colors.white : kPrimaryColor),
                      ))),
                ),
              )),
        );
      }
    }
    List<Widget> colorWidgetList = List<Widget>();

    if (widget.product['Variants'].length == 0) {
      colors = false;
    } else {
      //print('yes');
      colors = true;
      for (int i = 0; i < widget.product['Variants'].length; i++) {
        colorWidgetList.add(
          GestureDetector(
              onTap: () {
                totalVarPrice = 0.0;

                setState(() {
                  colorindex = i;
                  //print(colorindex);
                  selectedVariant = widget.product['Variants'][i]['Name'];
                  selectedVariantID =
                      widget.product['Variants'][i]['ID'].toString();
                  selectedVariantType =
                      widget.product['Variants'][i]['Type'].toString();
                  selectedVariantPrice =
                      widget.product['Variants'][i]['Price'].toString();

                  totalVarPrice = widget.product['Price'] +
                      widget.product['Variants'][i]['Price'] +
                      totalModPrice;
                  totalSendPrice = totalVarPrice;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  // width: stackWidth * 0.15,
                  height: stackWidth * 0.13,
                  decoration: BoxDecoration(
                      color: colorindex == i ? kPrimaryColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(color: kPrimaryColor)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        widget.product['Variants'][i]['Name'],
                        style: TextStyle(
                            fontFamily: 'UbuntuRegular',
                            color:
                                colorindex == i ? Colors.white : kPrimaryColor),
                      ))),
                ),
              )),
        );
      }
    }
    return SideInAnimation(
      4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "$priceGlobal ${totalSendPrice}",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          size
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18),
                  child: Text(
                    widget.product['Modifiers'][0]['Type'],
                    style: Theme.of(context).textTheme.headline3,
                  ).tr(),
                )
              : Container(),
          size
              ? Row(
                  children: textWidgetList,
                )
              : Container(),
          colors
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18),
                  child: Text(
                    widget.product['Variants'][0]['Type'],
                    style: Theme.of(context).textTheme.headline3,
                  ).tr(),
                )
              : Container(),
          colors
              ? Row(
                  children: colorWidgetList,
                )
              : Container()
        ],
      ),
    );
  }

  SideInAnimation buildRating() {
    return SideInAnimation(
      3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SmoothStarRating(
          color: kYellowColor,
          size: 25.0,
          isReadOnly: true,
          spacing: 5.0,
          starCount: 5,
          rating: widget.product.ratingValue,
          allowHalfRating: true,
          borderColor: kGreyColor,
        ),
      ),
    );
  }

  SideInAnimation buildTitleAndFavorite(BuildContext context) {
    return SideInAnimation(
      2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.product['Name'],
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 25.0),
            GestureDetector(
              onTap: () {
                Share.share(
                  "Product Name: ${widget.product['Name']} \nProduct Price: ${widget.product['Price']}"
                  "\nProduct Description: ${widget.product['Description']}"
                  "\n${widget.product['ItemImages'][selectedImage]}",
                );
              },
              child: Icon(
                Icons.share_outlined,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SideInAnimation buildCarousel(BuildContext context) {
    double stackWidth = MediaQuery.of(context).size.width;
    double stackHeight = MediaQuery.of(context).size.height;
    return SideInAnimation(
      1,
      child: Container(
        color: kBackgroundLightColor,
        child: Column(
          children: [
            SizedBox(
              height: stackHeight * 0.3,
              child: CachedNetworkImage(
                imageUrl: widget.product['ItemImages'][selectedImage],
                width: double.infinity,
                height: 250.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(widget.product['ItemImages'].length,
                    (index) => buildSmallProductPreview(index, context)),
              ],
            ),
            SizedBox(
              height: stackHeight * 0.02,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index, BuildContext context) {
    double stackWidth = MediaQuery.of(context).size.width;
    double stackHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(right: 10),
          height: stackHeight * 0.07,
          width: stackWidth * 0.15,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color:
                    kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: widget.product['ItemImages'][index],
              width: double.infinity,
              fit: BoxFit.fitWidth,
              height: 250.0,
            ),
          )),
    );
  }
}
