import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/data/model/class/customer_review.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_add_preview_state.dart';

class ReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewProvider({required this.apiService});

  dynamic _state;
  dynamic get state => _state;

Future<bool> addReview(String id, String name, String review) async {
  try {
    final result = await apiService.addReview(
      id: id,
      name: name,
      review: review,
    );

    // konversi hasil ke List<CustomerReview> dari API
    final customerReviews = (result["customerReviews"] as List)
        .map((item) => CustomerReview.fromJson(item))
        .toList();

    // ✅ langsung update state dengan list terbaru
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

