part of 'models.dart';

class Product {
  final int id;
  final String image;
  final String title;
  final String normalPrice;
  final String discountPrice;
  final double ratingValue;
  final String description;
  final bool isOffer;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;

  const Product({
    this.id,
    this.image,
    this.title,
    this.normalPrice,
    this.discountPrice,
    this.ratingValue,
    this.description,
    this.images,
    this.sizes,
    this.colors,

    this.isOffer,
  });
}


List<Product> productList = [
  Product(
      id: 1,
      title: "Nike Air Zoom Tempo Next",
      image: "assets/images/products/1_0.jpg",
      discountPrice: "0",
      normalPrice: "150",
      ratingValue: 4.0,
      isOffer: false,
      colors: [
        '0xFFF6625E',
        '0xFF836DB8',
        '0xFFDECB9C',
      ],
      description:
          "The Nike Air Zoom Tempo Next% mixes durability with a design that helps push you towards your personal best. The result is a shoe built like a racer, but made for your everyday training routine.",
      images: [
        "assets/images/products/ps4_console_blue_1.png",
        "assets/images/products/ps4_console_white_4.png",
        "assets/images/products/ps4_console_white_2.png",
        "assets/images/products/ps4_console_white_3.png",
      ],
      sizes: [
        "9",
        "10",
        "11",
        "12",
      ]
  ),
  Product(
      id: 2,
      title: "Nike Air Jordan Star",
      image: "assets/images/products/2_0.jpg",
      discountPrice: "50",
      normalPrice: "100",
      ratingValue: 4.0,
      isOffer: true,
      description:
          "With details inspired by the first release, the Air Jordan 3 Retro SE uses genuine leather and premium textiles to recreate the classic. It features Air cushioning in the heel and forefoot, plus denim-like overlays embellished with the iconic elephant //print.",
      images: [
        "assets/images/products/2_0.jpg",
        "assets/images/products/2_1.jpg",
        "assets/images/products/2_2.jpg",
        "assets/images/products/2_3.jpg",
      ]),
];



