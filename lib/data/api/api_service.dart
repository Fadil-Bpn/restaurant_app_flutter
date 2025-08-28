import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_submission/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  /// LIST
  Future<List<Restaurant>> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> restaurants = data['restaurants'];
      return restaurants.map((json) => Restaurant.fromListJson(json)).toList();
    } else {
      throw Exception("Gagal Memuat Daftar Restaurant");
    }
  }

  /// DETAIL
  Future<Restaurant> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final restaurant = data['restaurant'];
      return Restaurant.fromDetailJson(restaurant);
    } else {
      throw Exception("Gagal Memuat Detail Restaurant");
    }
  }

  /// SEARCH
  Future<List<Restaurant>> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
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
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id, "name": name, "review": review}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengirim review");
    }
  }
}
