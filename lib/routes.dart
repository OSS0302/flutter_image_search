import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/presentation/component/gallery/gallery_screen.dart';
import 'package:image_search_app/presentation/home/home_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/profile/profile_screen.dart';
import 'package:image_search_app/presentation/setting/setting_screen.dart';
import 'package:provider/provider.dart';  // Provider를 사용하기 위해 import 추가

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),GoRoute(
      path: '/pixabayScreen',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<PixabayViewModel>(), // 수정된 부분: searchUseCase 대신 getIt 호출
          child: const PixabayScreen(),
        );
      },
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
  ],
);