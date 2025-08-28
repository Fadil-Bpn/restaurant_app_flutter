import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_list_result_state.dart';
import '../data/api/api_service.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  RestaurantListResultState _state = RestaurantListNoneState();
  RestaurantListResultState get state => _state;

  Future<void> fetchAllRestaurants() async {
    try {
      _state = RestaurantListLoadingState();
      notifyListeners();

      final result = await apiService.getRestaurantList();

      if (result.isEmpty) {
        _state = RestaurantListErrorState("Data kosong");
      } else {
        _state = RestaurantListLoadedState(result);
      }
      notifyListeners();
    } catch (e) {
      _state = RestaurantListErrorState("Error: $e");
      notifyListeners();
    }
  }
}