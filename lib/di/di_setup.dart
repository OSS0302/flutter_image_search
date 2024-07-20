import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/Image_repository_impl.dart';
import 'package:image_search_app/data/repository/image_repository.dart';
import 'package:image_search_app/use_case/search_use_case.dart';

import '../presentation/image/image_view_model.dart';

final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<ImageRepository>(ImageRepositoryImpl());
  getIt.registerSingleton<SearchUseCase>(SearchUseCase(repository: getIt<ImageRepository>()));
  getIt.registerFactory<ImageViewModel>(() => ImageViewModel(searchUseCase: getIt<SearchUseCase>()));
}