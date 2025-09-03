import 'package:flutter/material.dart';
import 'package:restaurant_app_submission/screen/home/home_screen.dart';
import 'package:restaurant_app_submission/screen/page/restaurant_favorite_page.dart';

enum BottomNavItem { home, favorite }

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavItem _currentItem = BottomNavItem.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentItem.index,
        onTap: (index) {
          setState(() {
            _currentItem = BottomNavItem.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentItem) {
      case BottomNavItem.home:
        return const HomeScreen(); // halaman utama daftar restoran
      case BottomNavItem.favorite:
        return const FavoritePage(); // halaman favorite
    }
  }
}
