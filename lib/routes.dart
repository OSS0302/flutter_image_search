import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/hero/hero_screen.dart';
import 'package:image_search_app/presentation/image/image_screen.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';
import 'domain/model/image_item.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<ImageViewModel>(),
        child: ImageScreen(),
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
