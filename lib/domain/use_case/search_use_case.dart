import 'package:image_search_app/domain/model/pixabay_item.dart';
import 'package:image_search_app/domain/repository/pixabay_repository.dart';

import '../../core/result.dart';

class SearchUseCase {
  final PixabayRepository _repository;

  const SearchUseCase({
    required PixabayRepository repository,
  }) : _repository = repository;

  Future<Result<List<PixabayItem>>> execute(String query) async{
    final result = await _repository.getPixabayItems(query);
    switch(result) {

      case Success<List<PixabayItem>>():
        Result.success(result.data.toList());
      case Error<List<PixabayItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}