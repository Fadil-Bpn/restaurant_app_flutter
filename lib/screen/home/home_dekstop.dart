import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_detail_page.dart';
import 'package:restaurant_app_submission/screen/home/dekstop_card.dart';

class DesktopHome extends StatelessWidget {
  final List<Restaurant> restaurants;

  const DesktopHome({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       
        int crossAxisCount = constraints.maxWidth > 1200 ? 6 : 3;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 4,
            ),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCardDesktop(
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
          ),
        );
      },
    );
  }
}
