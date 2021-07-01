part of 'models.dart';

class Address {
  final String fullName;
  final String streetAddress;
  final String city;
  final String zipCode;
  final String phoneNumber;
  bool isSelected;

  Address(
      {this.fullName,
      this.streetAddress,
      this.city,
      this.zipCode,
      this.phoneNumber,
      this.isSelected});
}

List<Address> addressList = [
  Address(
    fullName: "Jessica Veranda",
    city: "Jakarta, Indonesia",
    phoneNumber: "+6285145148812",
    streetAddress: "Jl. R.Suprapto No. 16 A",
    zipCode: "88812",
    isSelected: false,
  ),
  Address(
    fullName: "Cindy Yuvia",
    city: "Pontianak, Indonesia",
    phoneNumber: "+6285145148812",
    streetAddress: "Jl. Ahmad Yani No. 12 B",
    zipCode: "514551",
    isSelected: false,
  ),
];
