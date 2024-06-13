import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/data/repository/image_repository_impl.dart';
import 'package:image_search_app/presentation/image/image_view_model.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerFactory<ImageViewModel>(() => ImageViewModel(repository: getIt<ImageRepository>()));
}