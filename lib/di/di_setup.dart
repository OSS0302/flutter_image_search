import 'package:get_it/get_it.dart';

import '../data/repository/pixabay_repository.dart';
import '../data/repository/pixabay_repository_impl.dart';
import '../presentation/pixabay/pixabay_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<PixabayRepository>(PixabayRepositoryImpl());
  getIt.registerFactory<PixabayViewModel>(() => PixabayViewModel(repository: getIt<PixabayRepository>()));
}