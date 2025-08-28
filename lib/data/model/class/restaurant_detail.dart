import 'package:restaurant_app_submission/data/model/restaurant.dart';

class RestaurantDetailResult {
  final Restaurant restaurant;

  RestaurantDetailResult({required this.restaurant});

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResult(
      restaurant: Restaurant.fromDetailJson(json['restaurant']),
    );
  }
}
