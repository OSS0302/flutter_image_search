import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/component/gallery/gallery_screen.dart';
import 'package:image_search_app/presentation/home/home_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_screen.dart';
import 'package:image_search_app/presentation/profile/profile_screen.dart';
import 'package:image_search_app/presentation/setting/setting_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PixabayScreen(),
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryScreen(), // 갤러리 화면 예시
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(), // 설정 화면 예시
    ),
    GoRoute(
      path: '/ProfileScreen',  // 내 프로필 경로
      builder: (context, state) => const ProfileScreen(), // 프로필 화면을 라우트에 추가
    ),
    // GoRoute(
    //   path: '/notifications',
    //   builder: (context, state) => const NotificationsScreen(), // 알림 화면 예시
    // ),
    // GoRoute(
    //   path: '/help',
    //   builder: (context, state) => const HelpScreen(), // 도움말 화면 예시
    // ),
  ],
);
