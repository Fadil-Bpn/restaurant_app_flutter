import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_detail_page.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_favorite_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Restaurants")),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteHasData) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = state.restaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(restaurant.name),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.location_on, size: 14),
                        const SizedBox(width: 4),
                        Text(restaurant.city),
                        const SizedBox(width: 12),
                        const Icon(Icons.star, size: 14, color: Colors.orange),
                        const SizedBox(width: 4),
                        Text(restaurant.rating.toString()),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailPage(id: restaurant.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is FavoriteNoData) {
            return Center(child: Text(state.message));
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
