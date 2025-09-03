import 'package:restaurant_app_submission/data/model/restaurant.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromDetailJson(json["restaurant"]),
    );
  }
}
