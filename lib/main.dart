import 'package:flutter/material.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/routes.dart';

void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Pixabay Image Search',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.cyan,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
