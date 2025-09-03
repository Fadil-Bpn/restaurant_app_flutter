import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/model/restaurant.dart';
import 'package:restaurant_app_submission/provider/restaurant_favorite_provider.dart';

class FavoriteIcon extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteIcon({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, _) {
        final isFav = favoriteProvider.isFavorite(restaurant.id);

        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.white,
          ),
          onPressed: () async {
            if (isFav) {
              await favoriteProvider.removeFavorite(restaurant.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Dihapus dari Favorit")),
              );
            } else {
              await favoriteProvider.addFavorite(restaurant);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Ditambahkan ke Favorit")),
              );
            }
          },
        );
      },
    );
  }
}
