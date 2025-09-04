import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_submission/screen/page/favorite_icon/favorite_icon.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_add_review.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_detail_result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;
  const RestaurantDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DetailRestaurantProvider(apiService: ApiService())
            ..fetchRestaurantDetail(id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Restoran"),
          actions: [
            Consumer<DetailRestaurantProvider>(
              builder: (context, provider, _) {
                if (provider.state is RestaurantDetailLoadedState) {
                  final restaurant =
                      (provider.state as RestaurantDetailLoadedState)
                          .restaurant;
                  return FavoriteIcon(restaurant: restaurant);
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, provider, _) {
            final state = provider.state;

            if (state is RestaurantDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantDetailLoadedState) {
              final restaurant = state.restaurant;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text(restaurant.city),
                        const Spacer(),
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(restaurant.rating.toString()),
                      ],
                    ),
                    const Divider(height: 24),

                    Text(
                      "Menu Makanan",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.foods.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final food = restaurant.menus.foods[index];
                          return Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dinner_dining_outlined,
                                  size: 28,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  food.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Menu Minuman",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.drinks.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final food = restaurant.menus.drinks[index];
                          return Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wine_bar,
                                  size: 28,
                                  color: Colors.blue,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  food.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 32),

                    Text(
                      "Ulasan Pelanggan",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: restaurant.customerReviews.map((review) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 4,
                              height: 70,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          review.date,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(review.review),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_comment),
                        label: const Text("Tambah Review"),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AddReviewPage(restaurantId: restaurant.id),
                            ),
                          );
                          if (result == true) {
                            Provider.of<DetailRestaurantProvider>(
                              context,
                              listen: false,
                            ).fetchRestaurantDetail(restaurant.id);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is RestaurantDetailErrorState) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
