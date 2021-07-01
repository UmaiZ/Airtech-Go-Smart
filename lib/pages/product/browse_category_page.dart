part of '../pages.dart';

class BrowseCategoryPage extends StatefulWidget {
  final subCategory;
  const BrowseCategoryPage({Key key, @required this.subCategory})
      : super(key: key);

  @override
  _BrowseCategoryPageState createState() => _BrowseCategoryPageState();
}

class _BrowseCategoryPageState extends State<BrowseCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildCategoryHeading(context),
              buildCategoryGrid(),
              SizedBox(height: 10.0),
              buildOtherHeading(context),
              buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Get.to(SearchPg());
          },
        ),
      ],
    );
  }

  StaggeredGridView buildProductGrid() {
    return StaggeredGridView.countBuilder(
      itemCount: productList.length,
      crossAxisCount: 4,
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      itemBuilder: (context, index) {
        var product = productList[index];
        return FadeInAnimation(
          index,
          child: ProductGridCard(
            product: product,
          ),
        );
      },
    );
  }

  SideInAnimation buildOtherHeading(BuildContext context) {
    return SideInAnimation(
      2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
        child: Text(
          'category.morebestproduct',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
    );
  }

  GridView buildCategoryGrid() {
    return GridView.builder(
      itemCount: categoryList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 4.0 / 7.0,
      ),
      itemBuilder: (context, index) {
        var category = categoryList[index];
        double duration = index / 2;
        return FadeInAnimation(
          duration.toInt(),
          child: CategoryCircle(
            category: category,
            onTap: () {
              Get.to(BrowseProductPage());
            },
          ),
        );
      },
    );
  }

  SideInAnimation buildCategoryHeading(BuildContext context) {
    return SideInAnimation(
      2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
        child: Text(
          'category.choosecategory',
          style: Theme.of(context).textTheme.headline4,
        ).tr(),
      ),
    );
  }
}
