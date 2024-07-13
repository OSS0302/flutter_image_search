import 'package:get_it/get_it.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';
import 'package:image_search_app/data/repository/pixabay_repository_impl.dart';
import 'package:image_search_app/presentation/pixabay/pixabay_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(repository: getIt<PixabayRepository>()));
}