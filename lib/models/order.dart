part of 'models.dart';

class Order {
  final String id;
  final String orderStatus;
  final String price;
  final String dateOrder;
  final String dateShipping;
  final String shipping;
  final String noResi;
  final String address;
  final int totalItem;
  final String shippingPrice;
  final String importCharges;
  final String totalPrice;
  final List<Product> items;

  Order(
      {this.id,
      this.orderStatus,
      this.price,
      this.dateOrder,
      this.dateShipping,
      this.shipping,
      this.noResi,
      this.address,
      this.totalItem,
      this.shippingPrice,
      this.importCharges,
      this.totalPrice,
      this.items});
}

List<Order> orderList = [
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "LQNSU346JK",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
  Order(
      id: "HHJK2322SK22",
      dateOrder: "August 1, 2020",
      orderStatus: "Shipping",
      totalItem: 2,
      price: "598.86",
      address: "3195  May Street, Crab Orchard, Kentucky",
      dateShipping: "August 2, 2020",
      importCharges: "128.00",
      noResi: "00023232322",
      shipping: "POS Regular",
      shippingPrice: "40.00",
      totalPrice: "766.86",
      items: [
        Product(
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
      ]),
];
