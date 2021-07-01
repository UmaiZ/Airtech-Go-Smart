part of '../widgets.dart';

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final void Function() onPressed;

  const PaymentCard({Key key, this.payment, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
        color: payment.isSelected
            ? Theme.of(context).primaryColor.withOpacity(.2)
            : null,
        child: Row(
          children: [
            SvgPicture.asset(payment.icon),
            SizedBox(width: 15.0),
            Text(
              payment.title,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
