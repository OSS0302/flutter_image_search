import 'package:flutter_image_search/presentation/pixabay/pixabay_screen.dart';
import 'package:flutter_image_search/presentation/pixabay/pixabay_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<PixabayViewModel>(),
        child: PixabayScreen(),
      ),
    ),
  ],
);
