import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';
import 'package:restaurant_app_submission/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_submission/screen/home/restaurant_card.dart';
import 'package:restaurant_app_submission/screen/home/search.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_detail_page.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_list_result_state.dart';
import 'package:restaurant_app_submission/style/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (_) =>
                        SearchRestaurantProvider(apiService: ApiService()),
                    child: const SearchScreen(),
                  ),
                ),
              );
            },
          ),

          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is RestaurantListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantListLoadedState) {
            final List<Restaurant> restaurants = state.restaurants;
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
          } else if (state is RestaurantListErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("Belum ada data"));
          }
        },
      ),
    );
  }
}
