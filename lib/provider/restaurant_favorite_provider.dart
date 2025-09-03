import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';
import 'package:restaurant_app_submission/data/favorite_local_db/favorite_db.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_favorite_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteDb database;

  FavoriteProvider({required this.database}) {
    getFavorites();
  }

  FavoriteState _state = FavoriteLoading();
  FavoriteState get state => _state;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Future<void> getFavorites() async {
    try {
      _state = FavoriteLoading();
      notifyListeners();

      final result = await database.getFavorites();
      if (result.isEmpty) {
        _state = FavoriteNoData("Belum ada restoran favorit");
        _favorites = [];
      } else {
        _favorites = result;
        _state = FavoriteHasData(result);
      }
    } catch (e) {
      _state = FavoriteError("Gagal memuat favorit: $e");
      _favorites = [];
    }
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((restaurant) => restaurant.id == id);
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await database.insertFavorite(restaurant);
    await getFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await database.removeFavorite(id);
    await getFavorites();
  }
}
