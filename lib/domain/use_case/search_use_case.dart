

import '../../core/result.dart';
import '../model/image_item.dart';
import '../repository/image_repository.dart';

class SearchUseCase {
  final ImageRepository _repository;

  const SearchUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async{
    final result = await _repository.getImageItems(query);
    switch(result){

      case Success<List<ImageItem>>():
       Result.success(result.data.toString());
      case Error<List<ImageItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}