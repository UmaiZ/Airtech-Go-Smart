part of 'models.dart';

class Category {
  final int id;
  final String name;
  final String icon;

  Category({this.id, this.name, this.icon});
}

List<Category> categoryList = [
  Category(
    id: 1,
    name: "category.shirt",
    icon: "assets/icons/shirt.png",
  ),
  Category(
    id: 2,
    name: "category.dress",
    icon: "assets/icons/dress.png",
  ),
  Category(
    id: 3,
    name: "category.manbag",
    icon: "assets/icons/manbag.png",
  ),
  Category(
    id: 4,
    name: "category.manpants",
    icon: "assets/icons/manpants.png",
  ),
  Category(
    id: 5,
    name: "category.manshoes",
    icon: "assets/icons/manshoes.png",
  ),
  Category(
    id: 6,
    name: "category.manunderwear",
    icon: "assets/icons/manunderwear.png",
  ),
  Category(
    id: 7,
    name: "category.tshirt",
    icon: "assets/icons/Tshirt.png",
  ),
  Category(
    id: 8,
    name: "category.womanbag",
    icon: "assets/icons/womanbag.png",
  ),
  Category(
    id: 9,
    name: "category.wowanpants",
    icon: "assets/icons/womanpants.png",
  ),
  Category(
    id: 10,
    name: "category.womanshoes",
    icon: "assets/icons/womanshoes.png",
  ),
  Category(
    id: 11,
    name: "category.womantshirt",
    icon: "assets/icons/womantshirt.png",
  ),
  Category(
    id: 12,
    name: "category.bikini",
    icon: "assets/icons/bikini.png",
  ),
];
