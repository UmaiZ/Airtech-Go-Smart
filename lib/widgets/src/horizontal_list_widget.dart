part of '../widgets.dart';

class HorizontalListView extends StatelessWidget {
  final List<Product> itemCount;
  HorizontalListView({
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.0,
      child: ListView.builder(
        itemCount: itemCount.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var product = itemCount[index];
          return ProductCard(
            product: product,
            isHorizontalList: true,
          );
        },
      ),
    );
  }
}
