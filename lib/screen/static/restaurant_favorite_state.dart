
import 'package:restaurant_app_submission/data/model/restaurant.dart';

sealed class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteHasData extends FavoriteState {
  final List<Restaurant> restaurants;
  FavoriteHasData(this.restaurants);
}

class FavoriteNoData extends FavoriteState {
  final String message;
  FavoriteNoData(this.message);
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
