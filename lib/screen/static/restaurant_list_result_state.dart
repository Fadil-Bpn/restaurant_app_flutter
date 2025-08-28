import 'package:restaurant_app_submission/data/model/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListLoadedState extends RestaurantListResultState {
  final List<Restaurant> restaurants;
  RestaurantListLoadedState(this.restaurants);
}

class RestaurantListErrorState extends RestaurantListResultState {
  final String message;
  RestaurantListErrorState(this.message);
}