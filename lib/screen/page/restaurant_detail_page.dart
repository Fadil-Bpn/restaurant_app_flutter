import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:restaurant_app_submission/provider/restaurant_detail_provider.dart';
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
          title: const Text("Detail Restauran"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, provider, _) {
            final state = provider.state;

            if (state is RestaurantDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantDetailLoadedState) {
              final restaurant = state.restaurant;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar restoran
                    Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    // Menu Makanan
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Menu Makanan",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Grid makanan
                              GridView.count(
                                crossAxisCount:
                                    3, // ganti ke 4 kalau mau 4 per baris
                                shrinkWrap:
                                    true, // biar bisa scroll bareng parent
                                physics: const NeverScrollableScrollPhysics(),
                                children: restaurant.menus.foods.map((food) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    margin: const EdgeInsets.all(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.fastfood,
                                            size: 28,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            food.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Menu Minuman
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Menu Minuman",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Grid makanan
                              GridView.count(
                                crossAxisCount:
                                    3, // ganti ke 4 kalau mau 4 per baris
                                shrinkWrap:
                                    true, // biar bisa scroll bareng parent
                                physics: const NeverScrollableScrollPhysics(),
                                children: restaurant.menus.drinks.map((drink) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    margin: const EdgeInsets.all(6),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.wine_bar,
                                            size: 28,
                                            color: Colors.purple,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            drink.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Customer Reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ulasan Pelanggan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: restaurant.customerReviews
                                .map(
                                  (review) => Card(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: ListTile(
                                      title: Text(review.name),
                                      subtitle: Text(review.review),
                                      trailing: Text(review.date),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
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
                          // refresh detail agar review terbaru muncul
                          Provider.of<DetailRestaurantProvider>(
                            context,
                            listen: false,
                          ).fetchRestaurantDetail(restaurant.id);
                        }
                      },
                    ),

                    const SizedBox(height: 16),
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
