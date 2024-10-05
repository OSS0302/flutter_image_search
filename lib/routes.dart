import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/presentation/hero/hero_screen.dart';
import 'package:image_search_app/presentation/main/main_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/setting/setting_screen.dart';
import 'package:image_search_app/presentation/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'di/di_setup.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => getIt<PixabayViewModel>(),
            child: const PixabayScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/hero',
          builder: (context, state) {
            final pixabayItem = state.extra as PixabayItem;
            return HeroScreen(pixabayItem: pixabayItem);
          },
        ),
      ],
    ),
  ],
);
