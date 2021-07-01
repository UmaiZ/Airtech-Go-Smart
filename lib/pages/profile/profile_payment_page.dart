part of '../pages.dart';

class ProfilePaymentPage extends StatefulWidget {
  @override
  _ProfilePaymentPageState createState() => _ProfilePaymentPageState();
}

class _ProfilePaymentPageState extends State<ProfilePaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.payment',
                style: Theme.of(context).textTheme.headline4)
            .tr(),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: paymentList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final payment = paymentList[index];
            return SideInAnimation(index,
                child: PaymentCard(
                  payment: payment,
                  onPressed: () {
                    setState(() {
                      paymentList.forEach((e) => e.isSelected = false);
                      payment.isSelected = true;
                    });
                  },
                ));
          },
        ),
      ),
    );
  }
}
