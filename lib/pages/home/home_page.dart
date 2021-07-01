part of '../pages.dart';

final List<String> imgList = [
  'assets/images/products/banner-png.png',
  'assets/images/products/banner-png.png',
  'assets/images/products/banner-png.png',
  'assets/images/products/banner-png.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      item,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.blue],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var bannerapiList = [];
  bool showBanner = false;

  var fetchedList = [];
  bool show = false;
  var items = {'Items': []};
  var featureProduct = [];
  String _LocationID;
  bool showFeat = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String sendToken;
  var cat = {'Cat': []};
  List<Widget> imageApiSlider;
  @override
  void initState() {
    dosomestuff();
    banner();
    bannerApiHit() {
      // http.Response res = await http.get(
      //   'http://retailapi.airtechsolutions.pk/api/menu/${_LocationID}',
      // );
    }
    Future.delayed(Duration.zero, () {
      this.firebaseCloudMessagingListeners(context);
    });
  }

  void firebaseCloudMessagingListeners(BuildContext context) {
    _firebaseMessaging.getToken().then((deviceToken) {
      sendToken = deviceToken;
      print("Firebase Device token: $sendToken");
    });
  }

  Future<List> dosomestuff() async {
    print(globalArray.globalArrayData);
    print('han karwa');
    final storage = new FlutterSecureStorage();
    _LocationID = await storage.read(key: "_LocationID");

    // http.Response res = await http.get(
    //   'http://retailapi.airtechsolutions.pk/api/menu/${_LocationID}',
    // );

    Map<String, dynamic> map = json.decode(globalArray.globalArrayData);

    if (map['description'] == "Success") {
      //print('show kr ');
      searchArray.searchArrayData.clear();
      List<dynamic> data = map["Categories"];

      data.forEach((category) {
        if (category['Subcategories'] != null) {
          category['Subcategories'].forEach((subcategory) {
            items['Items'].addAll(subcategory['Items']);

            searchArray.searchArrayData.addAll(subcategory['Items']);
          });
        }
      });

      data.forEach((category) {
        if (category['Subcategories'] != null) {
          category['Subcategories'].forEach((subcategory) {
            subcategory['Items'].forEach((item) {
              //print('feat');
              //print(item);
              if (item['IsFeatured'] ?? false) {
                //print('feat');
                //print(item);

                featureProduct.add(item);
              }
            });
          });
        }
      });
      items['Items'].shuffle();
      if (featureProduct.length >= 1) {
        //print('feature here');
        setState(() {
          showFeat = true;
        });
      }

      cat['Cat'].addAll(map['Categories']);
      //print(cat);

      Timer(
        Duration(milliseconds: 1000),
        () {
          setState(() {
            show = true;
          });
        },
      );
    }
  }

  Future<List> refresh() async {
    print('refresh call');

    final storage = new FlutterSecureStorage();
    String _LocationID = await storage.read(key: "_LocationID");
    String _UserID = await storage.read(key: "_UserID");
    print('API MENU');
    globalArray.globalArrayData = {};
    print(_LocationID);

    print(_UserID);
    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/menu/${_LocationID}/${_UserID}',
    );
    globalArray.globalArrayData = res.body;
    items['Items'].shuffle();

    Map<String, dynamic> map = json.decode(res.body);
    setState(() {});
  }

  Future<List> banner() async {
    print(globalArray.globalArrayData);
    print('han karwa');
    final storage = new FlutterSecureStorage();
    _LocationID = await storage.read(key: "_LocationID");

    http.Response res = await http.get(
      'http://retailapi.airtechsolutions.pk/api/banners/all/0',
    );

    Map<String, dynamic> map = json.decode(res.body);
    print('map banner ${map}');


    if (map['description'] == "Success") {
      map['Banners'].forEach((category) {
        print('banner');
        bannerapiList.add(category['Image'].toString());
        print(category);
        print(category['Image']);
      });

      print(bannerapiList);
      imageApiSlider = bannerapiList
          .map((item) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.replaceAll("\\", ""),
                        fit: BoxFit.cover,
                      )),
                ),
              ))
          .toList();
      setState(() {
        showBanner = true;
      });
    }
  }

  void navigateToBrowsePage() {
    Get.to(BrowseProductPage());
  }

  navigateToBrowseCategory() {
    Get.to(BrowseCategoryPage());
  }

  navigateToBrowseCategory2() {
    Get.to(BrowserCategoryPage2());
  }

  void navigateToNotificationPage() {
    Get.to(NotificationPage());
  }

  void navigateToSearchPg2() {
    Get.to(SearchPgExtra());
  }

  void navigateToProductDetailPage(Product product) {
    Get.to(ProductDetailPage(product: product));
  }

  navigateToBrowseByNewProduct() {
    Get.to(BrowseProductPage());
  }

  navigateToBrowseByCategory() {
    Get.to(BrowseProductPage());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xfff7f7f7),
      appBar: buildAppBar(context),
      body: Container(
        child: RefreshIndicator(
            onRefresh: () async {
              print('refresh');
              refresh();
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  showBanner ? buildSwiper(context) : Container(),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SideInAnimation(
                        2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              'home.categories',
                              style: Theme.of(context).textTheme.headline3,
                            ).tr(),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      show
                          ? SideInAnimation(2,
                              child: Container(
                                width: double.infinity,
                                height: Height * 0.151,
                                child: ListView.builder(
                                  itemCount: cat["Cat"].length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: GestureDetector(
                                          onTap: () {
                                            //print(cat["Cat"][index]['Subcategories']);
                                            Get.to(BrowserCategoryPage2(
                                                subCategory: cat["Cat"][index]
                                                    ['Subcategories']));
                                          },
                                          child: Container(
                                            width: 80.0,
                                            child: Column(
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),

                                                  child: Container(
                                                    color: kCardImageBCColor,
                                                    width: 60,
                                                    height: 60,
                                                    child: Image.network(
                                                      cat["Cat"]
                                                      [index]['Image'].toString().replaceAll("\\", ""),
                                                      width: double.infinity,
                                                      fit: BoxFit.fitWidth,
                                                      height: Height * 0.1,
                                                    ),
                                                  ),
                                                  // child: Image.asset(
                                                  //   product.image,
                                                  //   height: 150.0,
                                                  //   fit: BoxFit.cover,
                                                  //   width: double.infinity,
                                                  // ),
                                                ),
                                                // Container(
                                                //   width: 60.0,
                                                //   height: 60.0,
                                                //   decoration: BoxDecoration(
                                                //     shape: BoxShape.circle,
                                                //     border: Border.all(
                                                //         color: Theme.of(context)
                                                //             .accentColor
                                                //             .withOpacity(.2)),
                                                //     image: DecorationImage(
                                                //       image: AssetImage(
                                                //           'assets/icons/shirt.png'),
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(height: 12.0),
                                                Text(
                                                  show
                                                      ? cat["Cat"][index]
                                                          ['Name']
                                                      : 'Loading',
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ).tr(),
                                              ],
                                            ),
                                          )),
                                    );
                                  },
                                ),
                              ))
                          : Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SpinKitDoubleBounce(
                                      color: kPrimaryColor),
                                  const SpinKitDoubleBounce(
                                      color: kPrimaryColor),
                                  const SpinKitDoubleBounce(
                                      color: kPrimaryColor),
                                  const SpinKitDoubleBounce(
                                      color: kPrimaryColor),
                                  const SpinKitDoubleBounce(
                                      color: kPrimaryColor),
                                ],
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 2.0),
                  showFeat
                      ? Column(
                          children: [
                            SideInAnimation(
                              5,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    'New Products',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ).tr(),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            show
                                ? SideInAnimation(
                                    5,
                                    child: Container(
                                      width: double.infinity,
                                      height: height * 0.3,
                                      child: ListView.builder(
                                        itemCount: featureProduct.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var product = featureProduct[index];
                                          return ProductCard2(
                                            product: product,
                                            isHorizontalList: true,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  buildSpecialOffer(),
                  SizedBox(height: 15.0),
                  showFeat
                      ? Column(
                          children: [
                            SideInAnimation(
                              5,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Text(
                                    'Feature Product',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ).tr(),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            show
                                ? SideInAnimation(
                                    5,
                                    child: Container(
                                      width: double.infinity,
                                      height: height * 0.3,
                                      child: ListView.builder(
                                        itemCount: featureProduct.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var product = featureProduct[index];
                                          return ProductCard2(
                                            product: product,
                                            isHorizontalList: true,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 15.0),
                  // buildProductGrid(context),
                  // SizedBox(height: 25.0),
                  SideInAnimation(
                    5,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'All Products',
                          style: Theme.of(context).textTheme.headline3,
                        ).tr(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // show ? Text('show') : Text('now'),
                  show
                      ? StaggeredGridView.countBuilder(
                          itemCount: show ? items['Items'].length : 0,
                    crossAxisCount: 6,
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(2),
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          itemBuilder: (context, index) {
                            var product = show ? items['Items'][index] : null;
                            return FadeInAnimation(
                              index,
                              child: ProductCard2(
                                product: product,
                                isHorizontalList: false,
                              ),
                            );
                          },
                        )
                      : StaggeredGridView.countBuilder(
                          itemCount: 4,
                    crossAxisCount: 6,
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(2),
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          itemBuilder: (context, index) {
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child:
                                    SpinKitDoubleBounce(color: kPrimaryColor));
                          },
                        ),
                  SizedBox(height: 25.0),
                ],
              ),
            )),
      ),
    );
  }

  buildProductGrid(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/images/products/cameraItem3.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset(
                  'assets/images/products/634x598.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.4,

            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset(
              'assets/images/products/328-x459.jpg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Column buildRecommendedProduct(BuildContext context) {
    return Column(
      children: [
        SideInAnimation(
          5,
          child: buildHeading(
            context,
            title: 'home.recommended',
            onTap: navigateToBrowsePage,
          ),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          5,
          child: HorizontalListView(itemCount: productList),
        ),
      ],
    );
  }

  SideInAnimation buildSpecialOffer() {
    return SideInAnimation(
      4,
      child: Image.asset(
        'assets/images/products/umaiz.png',
        width: double.infinity,
        height: 250.0,
        fit: BoxFit.fitWidth,
      ),
      // child: CachedNetworkImage(
      //   imageUrl:
      //       'https://i.pinimg.com/564x/6a/3b/7b/6a3b7bf9bc206333bb29c4a2c21983ae.jpg',
      //   width: double.infinity,
      //   fit: BoxFit.fitWidth,
      //   height: 250.0,
      // ),
    );
  }

  Column buildNewProduct(BuildContext context) {
    return Column(
      children: [
        SideInAnimation(
          3,
          child: buildHeading(
            context,
            title: 'home.newproduct',
            onTap: navigateToBrowsePage,
          ),
        ),
        SizedBox(height: 15.0),
        SideInAnimation(
          3,
          child: HorizontalListView(itemCount: productList),
        ),
      ],
    );
  }

  SideInAnimation buildSwiper(BuildContext context) {
    return SideInAnimation(1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.4,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: showBanner ? imageApiSlider : null,
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Home',
        style: GoogleFonts.pacifico(fontSize: 25.0, color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.language,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      padding: EdgeInsets.all(8),
                      height: 135,
                      alignment: Alignment.center,
                      child: Column(children: [
                        GestureDetector(
                            child: Row(children: [
                              IconButton(
                                  icon: Icon(Icons.money_outlined,
                                      color: kPrimaryColor)),
                              Text('English')
                            ]),
                            onTap: () async {
                              final _storage = FlutterSecureStorage();

                              await _storage.write(key: 'id', value: 'en');
                              await _storage.write(key: 'ID', value: 'EN');
                              EasyLocalization.of(context).locale =
                                  Locale('en', 'EN');
                              RestartWidget.restartApp(context);
                            }),
                        GestureDetector(
                            child: Row(children: [
                              IconButton(
                                  icon: Icon(Icons.money_outlined,
                                      color: kPrimaryColor)),
                              Text('French')
                            ]),
                            onTap: () async {
                              context.locale = Locale('id', 'ID');

                              final _storage = FlutterSecureStorage();
                              await _storage.write(key: 'id', value: 'id');
                              await _storage.write(key: 'ID', value: 'ID');
                              EasyLocalization.of(context).locale =
                                  Locale('id', 'ID');
                              RestartWidget.restartApp(context);
                            }),
                      ]));
                });
          },
        ),
        IconButton(
          icon: Icon(
            FlutterIcons.search_mdi,
          ),
          onPressed: navigateToSearchPg2,
        ),
      ],
    );
  }

  Padding buildHeading(BuildContext context,
      {String title, void Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ).tr(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'home.seeall',
              style: Theme.of(context).textTheme.subtitle1,
            ).tr(),
          ),
        ],
      ),
    );
  }
}
