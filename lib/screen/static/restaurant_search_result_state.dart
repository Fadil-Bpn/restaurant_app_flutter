import 'package:restaurant_app_submission/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> results;
  RestaurantSearchLoadedState(this.results);
}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String message;
  RestaurantSearchErrorState(this.message);
}