import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/data/favorite_local_db/favorite_db.dart';
import 'package:restaurant_app_submission/provider/restaurant_add_preview_provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_search_provider.dart';
import 'package:restaurant_app_submission/screen/home/wrapper/main_page.dart';
import 'package:restaurant_app_submission/style/theme/theme.dart';
import 'package:restaurant_app_submission/data/api/api_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

void main() {
   if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchRestaurantProvider(apiService: context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(apiService: ApiService()),
        ),
         ChangeNotifierProvider(
          create: (_) => FavoriteProvider(database: FavoriteDb())..getFavorites(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App',
          theme: themeProvider.themeData,
          home: const MainPage(),
        );
      },
    );
  }
}
