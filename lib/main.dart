import 'package:flutter/material.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/routes.dart';

void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (context, value, child) {
          return MaterialApp.router(
            routerConfig: router,
            title: 'Pixabay Image Search',
            darkTheme: ThemeData.dark(),
            themeMode: value,
          );
        }
    );
  }
}
