import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/domain/use_case/search_use_case.dart';

import '../domain/repository/pixabay_repository.dart';
import '../presentation/pixabay/pixabay_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerSingleton<SearchUseCase>(SearchUseCase(repository: getIt<PixabayRepository>()));
  getIt.registerFactory<PixabayViewModel>(() =>PixabayViewModel(searchUseCase: getIt<SearchUseCase>()));

}