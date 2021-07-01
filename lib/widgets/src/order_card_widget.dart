part of '../widgets.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key key,
    @required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(OrderDetailPage(order: order));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.id,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Theme.of(context).primaryColor)),
            SizedBox(height: 12.0),
            Text(order.dateOrder, style: Theme.of(context).textTheme.subtitle2),
            Divider(),
            orderCardItem(context,
                title: "order.orderstatus", data: order.orderStatus),
            SizedBox(height: 12.0),
            orderCardItem(context,
                title: "order.items",
                data: "${order.totalItem} " + tr("order.itemspurchased")),
            SizedBox(height: 12.0),
            priceItem(context,
                title: "order.price", data: "\$ ${order.totalPrice}"),
          ],
        ),
      ),
    );
  }

  Widget orderCardItem(BuildContext context, {String title, String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle1).tr(),
        Text(data, style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }

  Widget priceItem(BuildContext context, {String title, String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.subtitle1).tr(),
        Text(data,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Theme.of(context).primaryColor)),
      ],
    );
  }
}
