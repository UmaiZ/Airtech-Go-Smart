part of 'models.dart';

class Payment {
  final String title;
  final String icon;
  bool isSelected;

  Payment({this.title, this.icon, this.isSelected});
}

List<Payment> paymentList = [
  Payment(
    title: 'Credit Card Or Debit',
    icon: 'assets/icons/debit.svg',
    isSelected: false,
  ),
  Payment(
    title: 'Paypal',
    icon: 'assets/icons/paypal.svg',
    isSelected: false,
  ),
  Payment(
    title: 'Bank transfer',
    icon: 'assets/icons/bank.svg',
    isSelected: false,
  ),
];
