import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';
import 'package:restaurant_app_submission/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_submission/screen/home/restaurant_card.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_detail_page.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_search_result_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchRestaurantProvider>(context, listen: false);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Cari restoran...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            searchProvider.searchRestaurant(value);
          },
        ),
      ),
      body: Consumer<SearchRestaurantProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is RestaurantSearchNoneState) {
            return const Center(child: Text("Ketik untuk mencari restoran 🍴"));
          } else if (state is RestaurantSearchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantSearchErrorState) {
            return Center(child: Text(state.message));
          } else if (state is RestaurantSearchLoadedState) {
            final List<Restaurant> restaurants = state.results;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RestaurantDetailPage(id: restaurant.id),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
