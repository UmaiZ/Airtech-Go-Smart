part of '../pages.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var items = {'Items': []};
  bool show = false;
  @override
  void initState() {
    dosomestuff();
  }

  Future<List> dosomestuff() async {

    Map<String, dynamic> map = json.decode(globalArray.globalArrayData);

    if (map['description'] == "Success") {
      //print('show kr ');

      List<dynamic> data = map["Categories"];
      data.forEach(
        (category) {
          if (category['Subcategories'] != null) {
            category['Subcategories'].forEach((subcategory) {
              final itemsToAdd = subcategory['Items'];
              final filteredItemsToAdd = itemsToAdd
                  .where((item) => WishList.wishlistArray.contains(item['ID']));
              items['Items'].addAll(filteredItemsToAdd);
            });
          }
        },
      );

      //print(items['Items']);
if(items['Items'].length >= 1){
  setState(() {
    show = true;
  });
}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'product.favoriteproduct',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
      body: Container(
          child: show
              ? StaggeredGridView.countBuilder(
                  itemCount: show ? items['Items'].length : 0,
                  crossAxisCount: 4,
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
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
                  'No Product in Wishlist',
                  style: Theme.of(context).textTheme.headline1,
                ).tr(),
                SizedBox(height: 15.0),
                Text(
                  'Please add products in your wishlist. Happy Shopping  :)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ).tr(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ],
            ),
          )),
    );
  }
}
