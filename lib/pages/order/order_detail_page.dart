part of '../pages.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // print();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('order.orderdetails', style: theme.textTheme.headline3).tr(),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text('order.product', style: theme.textTheme.headline3).tr(),
              SizedBox(height: 12.0),
              Column(
                children: order.items.map((e) {
                  return productCard(context, e);
                }).toList(),
              ),
              SizedBox(height: 15.0),
              Text('order.shippingdetails',
                      style: Theme.of(context).textTheme.headline3)
                  .tr(),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    orderCardItem(context,
                        title: "order.shippingdate", data: order.dateShipping),
                    SizedBox(height: 12.0),
                    orderCardItem(context,
                        title: "order.shippingtype", data: order.shipping),
                    SizedBox(height: 12.0),
                    orderCardItem(context,
                        title: "order.shippingid", data: order.noResi),
                    SizedBox(height: 12.0),
                    orderCardItem(context,
                        title: "order.destination", data: order.address),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Text('order.paymentdetails',
                      style: Theme.of(context).textTheme.headline3)
                  .tr(),
              SizedBox(height: 12.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    orderCardItem(context,
                        title: tr("order.items") + " (${order.totalItem})",
                        data: "\$ ${order.price}"),
                    SizedBox(height: 12.0),
                    orderCardItem(context,
                        title: "order.shipping",
                        data: "\$ ${order.shippingPrice}"),
                    SizedBox(height: 12.0),
                    orderCardItem(context,
                        title: "order.importcharges",
                        data: "\$ ${order.importCharges}"),
                    SizedBox(height: 12.0),
                    priceItem(context,
                        title: "order.totalprice",
                        data: "\$ ${order.totalPrice}"),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  Container productCard(BuildContext context, Product e) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Theme.of(context).accentColor),
      ),
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              e.image,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: Theme.of(context).textTheme.headline4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  "\$ ${e.normalPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: kPrimaryColor),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: 'ED4337'.toColor(),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget orderCardItem(BuildContext context, {String title, String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline5).tr(),
        SizedBox(width: 60.0),
        Expanded(
          child: Text(data,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subtitle2)
              .tr(),
        ),
      ],
    );
  }

  Widget priceItem(BuildContext context, {String title, String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline4).tr(),
        Text(data, style: Theme.of(context).textTheme.subtitle2),
      ],
    );
  }
}
