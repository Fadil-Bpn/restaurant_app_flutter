import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_detail_result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  RestaurantDetailResultState _state = RestaurantDetailNoneState();
  RestaurantDetailResultState get state => _state;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = RestaurantDetailLoadingState();
      notifyListeners();

      final data = await apiService.getRestaurantDetail(id);
      _state = RestaurantDetailLoadedState(data);
    } catch (e) {
      _state = RestaurantDetailErrorState("Gagal memuat detail: $e");
    }
    notifyListeners();
  }

  Future addReview(String restaurantId, String text, String text2) async {}
  
}
