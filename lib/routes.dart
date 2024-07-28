import 'package:go_router/go_router.dart';
import 'package:image_search_app/presentation/image/image_screen.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<ImageViewModel>(),
        child: ImageScreen(),
      ),
    ),
  ],
);
