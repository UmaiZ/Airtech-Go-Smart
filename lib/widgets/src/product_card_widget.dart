part of '../widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isHorizontalList;

  const ProductCard(
      {Key key, @required this.product, @required this.isHorizontalList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isHorizontalList ? 15.0 : 0.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Get.to(ProductDetailPage(product: product));
        },
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
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text(
                        "\$${product.normalPrice}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 5.0),
                      product.isOffer
                          ? Text(
                              "\$${product.discountPrice}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                            )
                          : Container(),
                    ],
                  ),
                  // SizedBox(height: 3.0),
                  // SmoothStarRating(
                  //   color: kYellowColor,
                  //   spacing: 1.0,
                  //   size: 15.0,
                  //   rating: product.ratingValue,
                  //   isReadOnly: true,
                  //   starCount: 5,
                  //   allowHalfRating: true,
                  //   borderColor: Theme.of(context).accentColor,
                  // ),
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
                          color: Theme.of(context).primaryColor.withOpacity(.8),
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
