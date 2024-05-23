import 'package:flutter_image_search/data/repository/pixabay_repository.dart';
import 'package:flutter_image_search/data/repository/pixabay_repository_impl.dart';
import 'package:flutter_image_search/presentation/pixabay/pixabay_view_model.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(repository: getIt<PixabayRepository>()));
}