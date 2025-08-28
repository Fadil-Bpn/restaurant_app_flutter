import 'package:restaurant_app_submission/data/model/class/category.dart';

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Category>.from(
        json['foods'].map((x) => Category.fromJson(x)),
      ),
      drinks: List<Category>.from(
        json['drinks'].map((x) => Category.fromJson(x)),
      ),
    );
  }
}
