import 'package:restaurant_app_submission/data/model/class/customer_review.dart';

sealed class RestaurantAddReviewResultState {}

/// ketika belum ada aksi
class RestaurantAddReviewNoneState extends RestaurantAddReviewResultState {}

/// ketika loading (submit review)
class RestaurantAddReviewLoadingState extends RestaurantAddReviewResultState {}

/// ketika berhasil submit review
class RestaurantAddReviewLoadedState extends RestaurantAddReviewResultState {
  final List<CustomerReview> customerReviews;
  RestaurantAddReviewLoadedState(this.customerReviews);
}

/// ketika gagal
class RestaurantAddReviewErrorState extends RestaurantAddReviewResultState {
  final String message;
  RestaurantAddReviewErrorState(this.message);
}
