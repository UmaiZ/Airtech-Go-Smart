part of '../pages.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final themeProv = Provider.of<ThemeChangerProvider>(context);

    return theme.copyWith(
      backgroundColor: theme.backgroundColor,
      primaryColor: theme.backgroundColor,
      iconTheme: theme.iconTheme,
      hintColor: theme.accentColor,
      textTheme: TextTheme(
        subtitle1: GoogleFonts.poppins(
          fontSize: 14.0,
          color: themeProv.isLightTheme
              ? kBackgroundDarkColor
              : kBackgroundLightColor,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = searchArray.searchArrayData.map((e) => e).toList();
    final dataList = query.isEmpty
        ? suggestionList
            .where((element) => element['Name'].toLowerCase().startsWith(query))
            .toList()
        : suggestionList
            .where((element) => element['Name'].toLowerCase().startsWith(query))
            .toList();
    return dataList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/no_reviews.png',
                      width: MediaQuery.of(context).size.width / 2),
                  SizedBox(height: 15.0),
                  Text(
                    'search.notfoundtitle',
                    style: Theme.of(context).textTheme.headline1,
                  ).tr(),
                  SizedBox(height: 15.0),
                  Text('search.notfoundsubtitle',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1)
                      .tr(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        : StaggeredGridView.countBuilder(
            itemCount: searchArray.searchArrayData.length,
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            itemBuilder: (context, index) {
              var product = searchArray.searchArrayData[index];
              return FadeInAnimation(
                index,
                child: SearchProductGridCard(
                  product: product,
                  onTap: () {
                    Get.to(ProductDetailPage2(product: product));
                  },
                ),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = searchArray.searchArrayData.map((e) => e).toList();
    final dataList = query.isEmpty
        ? suggestionList
            .where((element) => element['Name'].toLowerCase().startsWith(query))
            .toList()
        : suggestionList
            .where((element) => element['Name'].toLowerCase().startsWith(query))
            .toList();
    final themeProv = Provider.of<ThemeChangerProvider>(context);
    return ListView.builder(
      itemCount: searchArray.searchArrayData.length,
      itemBuilder: (context, index) {
        var data = searchArray.searchArrayData[index];
        return Column(
          children: <Widget>[
            ListTile(
              title: RichText(
                text: TextSpan(
                  text: data.Name.substring(0, query.length),
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: themeProv.isLightTheme
                            ? kPrimaryLightFontColor
                            : kPrimaryDarkFontColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                  children: [
                    TextSpan(
                      text: data.Name.substring(query.length),
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: themeProv.isLightTheme
                                ? kPrimaryLightFontColor
                                : kPrimaryDarkFontColor,
                            fontSize: 15.0,
                          ),
                    ),
                  ],
                ),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Get.to(ProductDetailPage2(product: data));
              },
            ),
            Divider(),
          ],
        );
      },
    );
  }
}

class SearchProductGridCard extends StatelessWidget {
  final void Function() onTap;
  final Product product;

  const SearchProductGridCard({Key key, @required this.onTap, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChangerProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Container(
          width: 150.0,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      product.image,
                      height: 150.0,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    product.title,
                    style: GoogleFonts.poppins(
                      color: theme.isLightTheme
                          ? kPrimaryLightFontColor
                          : kPrimaryDarkFontColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text(
                        "\$${product.normalPrice}",
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),
                      product.isOffer
                          ? Text(
                              "\$${product.discountPrice}",
                              style: GoogleFonts.poppins(
                                color: theme.isLightTheme
                                    ? kSecondaryLightFontColor
                                    : kSecondaryDarkFontColor,
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 3.0),
                  SmoothStarRating(
                    color: kYellowColor,
                    spacing: 1.0,
                    size: 15.0,
                    rating: product.ratingValue,
                    isReadOnly: true,
                    starCount: 5,
                    allowHalfRating: true,
                    borderColor: Theme.of(context).accentColor,
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              product.isOffer
                  ? Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: kPrimaryColor.withOpacity(.8),
                        ),
                        height: 20.0,
                        child: Center(
                          child: Text(
                            "-50%",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: kBackgroundLightColor),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                    size: 23.0,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
