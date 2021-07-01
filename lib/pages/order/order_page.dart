part of '../pages.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool showCards = false;
  var data;
  var ordersData = [];
  String priceGlobal;
  String _DeliveryCharges;
  String _TaxPercentTaxPercent;
  @override
  void initState() {
    this.getOrders();
    getGlobal();

  }




  getGlobal() async {
    final storage = new FlutterSecureStorage();
    priceGlobal = await storage.read(key: "_Currency");

    _TaxPercentTaxPercent = await storage.read(key: "_TaxPercentTaxPercent");
    _DeliveryCharges = await storage.read(key: "_DeliveryCharges");
    setState(() {

    });
  }

  getOrders() async{
    final storage = new FlutterSecureStorage();

    String userId = await storage.read(key: "_userID");
    String url =
        'http://retailapi.airtechsolutions.pk/api/orders/customer/${userId}/0';

    print(url);
    http.Response res = await http.get(
      url,
    );
    var data = json.decode(res.body.toString());
    //print(data);

    if(data['description'].toString() == "Success"){
      //print(data['Orders']);
      //print(data['Orders'].length);
      ordersData.addAll(data['Orders']);  // Add your data to array or list
//print(ordersData);
//print(ordersData[0]['ID'].toString());
      setState(() {
        showCards = true;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order', style: Theme.of(context).textTheme.headline4),
      ),
      body: showCards ? Container(
        child: ListView.builder(
          itemCount: ordersData.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
          itemBuilder: (context, index) {
            var order = ordersData[index];
            return SideInAnimation(index, child:GestureDetector(
              onTap: () {
                Get.to(OrderDetailPage2(order: order));
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
                    Text(ordersData[index]['ID'].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Theme.of(context).primaryColor)),
                    SizedBox(height: 12.0),
                    Text(ordersData[index]['OrderDate'].toString(), style: Theme.of(context).textTheme.subtitle2),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Status', style: Theme.of(context).textTheme.subtitle1).tr(),
                        Text(ordersData[index]['StatusID'].toString(), style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                    SizedBox(height: 12.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Items', style: Theme.of(context).textTheme.subtitle1).tr(),
                        Text("${ordersData[index]['OrderDetails'].length} " + "Items Purchased", style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                    SizedBox(height: 12.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price", style: Theme.of(context).textTheme.subtitle1).tr(),
                        Text("$priceGlobal ${ordersData[index]['OrderCheckouts']['AmountTotal'].toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Theme.of(context).primaryColor)),
                      ],
                    )
                  ],
                ),
              ),
            ));
          },
        ),
      ) : Container(),
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
