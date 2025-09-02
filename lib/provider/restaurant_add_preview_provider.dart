import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/data/model/class/customer_review.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_add_preview_state.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewProvider({required this.apiService})
    : _state = RestaurantAddReviewNoneState();

  RestaurantAddReviewResultState _state;
  RestaurantAddReviewResultState get state => _state;

  Future<bool> addReview(String id, String name, String review) async {
    try {
      final result = await apiService.addReview(
        id: id,
        name: name,
        review: review,
      );

      final customerReviews = (result["customerReviews"] as List)
          .map((item) => CustomerReview.fromJson(item))
          .toList();

      _state = RestaurantAddReviewLoadedState(customerReviews);
      notifyListeners();
      return true;
    } catch (e) {
      _state = RestaurantAddReviewErrorState(e.toString());
      notifyListeners();
      return false;
    }
  }
}
