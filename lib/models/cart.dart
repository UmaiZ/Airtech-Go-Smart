class Cart {
  int id;
  String title;
  String image;
  String price;
  String color;
  String sizeselect;

  Cart({
    this.id,
    this.title,
    this.image,
    this.price,
    this.color,
    this.sizeselect,

  });



  factory Cart.fromJson(Map<String, dynamic> data) => new Cart(
    id: data["id"],
    title: data["title"],
    image: data["image"],
    price: data["price"],
    color: data["color"],
    sizeselect: data["sizeselect"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
    "color": color,
    "sizeselect": sizeselect,

  };
}