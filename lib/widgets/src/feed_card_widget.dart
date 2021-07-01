part of '../widgets.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({
    Key key,
    @required this.feed,
  }) : super(key: key);

  final Notifications feed;

  void navigateToProductDetailPage() {
    Get.to(ProductDetailPage(product: feed.product));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: navigateToProductDetailPage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                feed.product.image,
                width: 70.0,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feed.title,
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 8.0),
                  ReadMoreText(
                    feed.description,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.left,
                    trimLines: 3,
                    colorClickableText: Theme.of(context).primaryColor,
                    trimMode: TrimMode.Line,
                  ),
                  SizedBox(height: 12.0),
                  Text('${feed.date} ${feed.time}',
                      style: Theme.of(context).textTheme.subtitle2),
                  SizedBox(height: 12.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
