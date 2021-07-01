part of '../pages.dart';

class BrowseProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: StaggeredGridView.countBuilder(
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
      ),
    );
  }
}
