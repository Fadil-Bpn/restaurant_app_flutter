import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_submission/data/api/enum_endpoint.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<List<Restaurant>> getRestaurantList() async {
    final response = await http.get(
      Uri.parse("$_baseUrl${ApiEndpoint.list.path()}"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> restaurants = data['restaurants'];
      return restaurants.map((json) => Restaurant.fromListJson(json)).toList();
    } else {
      throw Exception("Gagal Memuat Daftar Restaurant");
    }
  }

  Future<Restaurant> getRestaurantDetail(String id) async {
    final responseDetail = await http.get(
      Uri.parse("$_baseUrl${ApiEndpoint.detail.path(id)}"),
    );
    if (responseDetail.statusCode == 200) {
      final data = jsonDecode(responseDetail.body);
      final restaurant = data['restaurant'];
      return Restaurant.fromDetailJson(restaurant);
    } else {
      throw Exception("Gagal Memuat Detail Restaurant");
    }
  }

  Future<List<Restaurant>> searchRestaurants(String query) async {

     await Future.delayed(const Duration(milliseconds: 1000));
    final responseSearch = await http.get(
      Uri.parse("$_baseUrl${ApiEndpoint.search.path(query)}"),
    );
    if (responseSearch.statusCode == 200) {
      final data = jsonDecode(responseSearch.body);
      final List<dynamic> restaurants = data['restaurants'];
      return restaurants.map((json) => Restaurant.fromListJson(json)).toList();
    } else {
      throw Exception("Gagal Mencari Restaurant");
    }
  }

  Future<Map<String, dynamic>> addReview({
  required String id,
  required String name,
  required String review,
}) async {
  final responseReview = await http.post(
    Uri.parse("$_baseUrl${ApiEndpoint.review.path()}"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "id": id,
      "name": name,
      "review": review,
    }),
  );

  if (responseReview.statusCode == 200) {
    return jsonDecode(responseReview.body);
  } else {
    final errorResponse = jsonDecode(responseReview.body);
    final message = errorResponse['message'] ?? 'Unknown error';
    throw Exception("Error ${responseReview.statusCode}: $message");
  }
}
}
