import 'package:restaurant_app_submission/data/model/class/customer_review.dart';

sealed class RestaurantAddReviewResultState {}

class RestaurantAddReviewNoneState extends RestaurantAddReviewResultState {}

class RestaurantAddReviewLoadingState extends RestaurantAddReviewResultState {}

class RestaurantAddReviewLoadedState extends RestaurantAddReviewResultState {
  final List<CustomerReview> customerReviews;
  RestaurantAddReviewLoadedState(this.customerReviews);
}

class RestaurantAddReviewErrorState extends RestaurantAddReviewResultState {
  final String message;
  RestaurantAddReviewErrorState(this.message);
}
