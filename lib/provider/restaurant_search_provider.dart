import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_search_result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  RestaurantSearchResultState _state = RestaurantSearchNoneState();
  RestaurantSearchResultState get state => _state;

  Future<void> searchRestaurant(String query) async {
    if (query.isEmpty) {
      _state = RestaurantSearchNoneState();
      notifyListeners();
      return;
    }

    try {
      _state = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await apiService.searchRestaurants(query);

      if (result.isEmpty) {
        _state = RestaurantSearchErrorState("Tidak ada hasil untuk \"$query\"");
      } else {
        _state = RestaurantSearchLoadedState(result);
      }
    } catch (e) {
      _state = RestaurantSearchErrorState("Error: $e");
    }
    notifyListeners();
  }
}
