import 'package:restaurant_app_submission/data/model/restaurant.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  final Restaurant restaurant;
  RestaurantDetailLoadedState(this.restaurant);
}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String message;
  RestaurantDetailErrorState(this.message);
}