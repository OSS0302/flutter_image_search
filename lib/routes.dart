import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/presentation/FAQ/faq_screen.dart';
import 'package:image_search_app/presentation/alarm/alaram_screen.dart';
import 'package:image_search_app/presentation/component/gallery/gallery_screen.dart';
import 'package:image_search_app/presentation/contactus/contact_us_screen.dart';
import 'package:image_search_app/presentation/help/help_screen.dart';
import 'package:image_search_app/presentation/home/home_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_screen.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';
import 'package:image_search_app/presentation/profile/add/additional_info_screen.dart';
import 'package:image_search_app/presentation/profile/profile_screen.dart';
import 'package:image_search_app/presentation/setting/app/app_info_screen.dart';
import 'package:image_search_app/presentation/setting/pw/change_password_screen.dart';
import 'package:image_search_app/presentation/setting/pw/security_settings_screen.dart';
import 'package:image_search_app/presentation/setting/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:image_search_app/presentation/hero/hero_screen.dart';

import 'di/di_setup.dart'; // HeroScreen import

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/pixabayScreen',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<PixabayViewModel>(),
          child: const PixabayScreen(),
        );
      },
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/ProfileScreen',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/helpScreen',
      builder: (context, state) => const HelpScreen(),
    ),
    GoRoute(
      path: '/alarmScreen',
      builder: (context, state) => const AlarmScreen(),
    ),
    GoRoute(
      path: '/additional-info',
      builder: (context, state) => const AdditionalInfoScreen(),
    ),
    GoRoute(
      path: '/FAQScreen',
      builder: (context, state) => const FAQScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: '/appInfo',
      builder: (context, state) => const AppInfoScreen(),
    ),
    GoRoute(
      path: '/pwScreen',
      builder: (context, state) => const SecuritySettingsScreen(),
    ),
    GoRoute(
      path: '/changePw',
      builder: (context, state) => const ChangePasswordScreen(),
    ),GoRoute(
      path: '/changeSecondary',
      builder: (context, state) => const ChangeSecondaryPasswordScreen(),
    ),
    GoRoute(
      path: '/hero',
      builder: (context, state) {
        final pixabayItem = state.extra as PixabayItem;
        return HeroScreen(pixabayItem: pixabayItem,);
      },
    ),
  ],
);