part of 'models.dart';

class Notifications {
  final String title;
  final String description;
  final String date;
  final String time;
  final Product product;

  Notifications(
      {this.title, this.description, this.date, this.time, this.product});
}

List<Notifications> offerList = [
  Notifications(
    title: "notification.summersale",
    description: "notification.mockdesc",
    date: "April 30, 2020",
    time: "1:10 PM",
  ),
  Notifications(
    title: "notification.buy1get1",
    description: "notification.mockdesc",
    date: "July 10, 2020",
    time: "15:00 PM",
  ),
  Notifications(
    title: "notification.bestoffer",
    description: "notification.mockdesc",
    date: "August 17, 2020",
    time: "05:10 AM",
  ),
];

List<Notifications> feedList = [
  Notifications(
    title: "Best product",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "April 30, 2020",
    time: "1:10 PM",
    product: Product(
        id: 1,
        title: "Nike Air Zoom Tempo Next",
        image: "assets/images/products/1_0.jpg",
        discountPrice: "0",
        normalPrice: "150",
        ratingValue: 4.0,
        isOffer: false,
        description:
            "The Nike Air Zoom Tempo Next% mixes durability with a design that helps push you towards your personal best. The result is a shoe built like a racer, but made for your everyday training routine.",
        images: [
          "assets/images/products/1_0.jpg",
          "assets/images/products/1_1.jpg",
          "assets/images/products/1_2.jpg",
          "assets/images/products/1_3.jpg",
        ]),
  ),
  Notifications(
    title: "Recommended for you",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "July 10, 2020",
    time: "15:00 PM",
    product: Product(
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
  ),
  Notifications(
    title: "Best seller",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "August 17, 2020",
    time: "05:10 AM",
    product: Product(
        id: 2,
        title: "Nike Air Zoom Tempo Next",
        image: "assets/images/products/1_0.jpg",
        discountPrice: "0",
        normalPrice: "150",
        isOffer: false,
        ratingValue: 4.0,
        description:
            "The Nike Air Zoom Tempo Next% mixes durability with a design that helps push you towards your personal best. The result is a shoe built like a racer, but made for your everyday training routine.",
        images: [
          "assets/images/products/1_0.jpg",
          "assets/images/products/1_1.jpg",
          "assets/images/products/1_2.jpg",
          "assets/images/products/1_3.jpg",
        ]),
  ),
];

List<Notifications> activityList = [
  Notifications(
    title: "Best product",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "April 30, 2020",
    time: "1:10 PM",
  ),
  Notifications(
    title: "Recommended for you",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "July 10, 2020",
    time: "15:00 PM",
  ),
  Notifications(
    title: "Best seller",
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    date: "August 17, 2020",
    time: "05:10 AM",
  ),
];
