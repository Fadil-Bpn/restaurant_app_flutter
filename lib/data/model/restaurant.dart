import 'package:restaurant_app_submission/data/model/class/category.dart';
import 'package:restaurant_app_submission/data/model/class/customer_review.dart';
import 'package:restaurant_app_submission/data/model/class/menus.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromListJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: "", 
        pictureId: json['pictureId'],
        categories: [], 
        menus: Menus(foods: [], drinks: []), 
        rating: (json['rating'] as num).toDouble(),
        customerReviews: [], 
      );

  factory Restaurant.fromDetailJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x)),
        ),
        menus: Menus.fromJson(json['menus']),
        rating: (json['rating'] as num).toDouble(),
        customerReviews: List<CustomerReview>.from(
          json['customerReviews'].map((x) => CustomerReview.fromJson(x)),
        ),
      );
}
