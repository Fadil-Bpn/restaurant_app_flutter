import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_list_result_state.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Restoran"),
      ),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          switch (state) {
            case RestaurantListLoadingState():
              return const Center(child: CircularProgressIndicator());

            case RestaurantListLoadedState(:final restaurants):
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final resto = restaurants[index];
                  return ListTile(
                    leading: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}",
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(resto.name),
                    subtitle: Text("${resto.city} • ⭐ ${resto.rating}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailPage(id: resto.id), 
                        ),
                      );
                    },
                  );
                },
              );

            case RestaurantListErrorState(:final message):
              return Center(child: Text(message));

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
