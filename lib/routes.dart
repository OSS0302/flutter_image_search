import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/hero/hero_screen.dart';
import 'package:image_search_app/presentation/image/image_screen.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:provider/provider.dart';

import 'data/model/image_item.dart';
import 'di/di_setup.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<ImageViewModel>(),
        child: const ImageScreen(),
      ),
    ),
    GoRoute(
      path: '/hero',
      builder: (context, state) {
        final imageItem = state.extra as ImageItem;
        return HeroScreen(imageItem: imageItem);
      },
    ),
  ],
);
