part of '../pages.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key key, @required this.product}) : super(key: key);
  final Product product;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
  String selectedVariant = "";

  @override
  Widget build(BuildContext context) {
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
                    buildOtherHeading(context),
                    buildOtherProducts(),
                    SizedBox(height: 100.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final storage = new FlutterSecureStorage();

          String imi = await storage.read(key: "imei");
          //print(imi);
          if (imi == "loginhuavaha") {
            //print('login');

            var cart = Cart();

            cart.id = widget.product.id;
            cart.title = widget.product.title;
            cart.image = widget.product.image;
            cart.price = widget.product.normalPrice;
            cart.variant = selectedVariant;
            cart.modifier = selectedModifier;
            //print(cart);

            final dbHelper = DatabaseHelper.instance;

            final id = await dbHelper.insert(cart);
            // Model.createCustomer(map);

          } else {
            //print('not login');
            Get.offAll(SignInPage());
          }
        },
        backgroundColor: kPrimaryColor,
        label: Text(
          'product.addtocart',
          style: Theme.of(context).textTheme.button,
        ).tr(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: Search());
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
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

  FadeInAnimation buildRatingIcon(BuildContext context) {
    return FadeInAnimation(
      8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            SmoothStarRating(
              color: kYellowColor,
              size: 25.0,
              isReadOnly: true,
              spacing: 5.0,
              starCount: 5,
              rating: 3.5,
              allowHalfRating: true,
              borderColor: kGreyColor,
            ),
            SizedBox(width: 12.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '4.5  ',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  TextSpan(
                    text: '(5) ' + tr("product.reviews"),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FadeInAnimation buildRatingHeading(BuildContext context) {
    return FadeInAnimation(
      7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'product.reviews',
              style: Theme.of(context).textTheme.headline3,
            ).tr(),
            GestureDetector(
              onTap: () {
                Get.to(ReviewsPage());
              },
              child: Text(
                'product.seemore',
                style: Theme.of(context).textTheme.subtitle2,
              ).tr(),
            ),
          ],
        ),
      ),
    );
  }

  FadeInAnimation buildDescriptionBody(BuildContext context) {
    return FadeInAnimation(
      6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
        child: ReadMoreText(
          widget.product.description,
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

    if (widget.product.sizes == null) {
      size = false;
    } else {
      //print('yes');
      size = true;
      for (int i = 0; i < widget.product.sizes.length; i++) {
        textWidgetList.add(
          GestureDetector(
              onTap: () {
                setState(() {
                  dateindex = i;
                  //print(dateindex);
                  //print(widget.product.sizes[i]);
                  selectedModifier = widget.product.sizes[i];
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: stackWidth * 0.13,
                  height: stackWidth * 0.13,
                  decoration: BoxDecoration(
                      color: dateindex == i ? kPrimaryColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(color: kPrimaryColor)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        widget.product.sizes[i],
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

    if (widget.product.colors == null) {
      colors = false;
    } else {
      //print('yes');
      colors = true;
      for (int i = 0; i < widget.product.colors.length; i++) {
        colorWidgetList.add(
          GestureDetector(
              onTap: () {
                setState(() {
                  colorindex = i;
                  //print(widget.product.colors[i]);
                  //print(colorindex);
                  selectedVariant = widget.product.colors[i];
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: stackWidth * 0.13,
                  height: stackWidth * 0.13,
                  decoration: BoxDecoration(
                    color: Color(int.parse(widget.product.colors[i])),
                    border: Border.all(
                        color: colorindex == i
                            ? kPrimaryColor
                            : kBackgroundLightColor,
                        width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: null,
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
              "\$ ${widget.product.normalPrice}",
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
                    'Select Size',
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
                    'Select Color',
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
                widget.product.title,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(width: 25.0),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.favorite_border,
                color: Theme.of(context).errorColor,
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
        color: kCardImageBCColor,
        child: Column(
          children: [
            SizedBox(
              height: stackHeight * 0.3,
              child: Image.asset(widget.product.images[selectedImage]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(widget.product.images.length,
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
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.product.images[index]),
      ),
    );
  }
}
