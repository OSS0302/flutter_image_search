import 'package:image_search_app/domain/respository/image_repository.dart';

import '../../core/result.dart';
import '../model/image_item.dart';

class ImageSearchUseCase {
  final ImageRepository _repository;

  const ImageSearchUseCase({
    required ImageRepository repository,
  }) : _repository = repository;

  Future<Result<List<ImageItem>>> execute(String query) async{
    final result = await _repository.getImageItems(query);
    switch(result) {

      case Success<List<ImageItem>>():
        Result.success(result.data.toList());
      case Error<List<ImageItem>>():
        Result.error(Exception(result.e.toString()));
    }
    return result;
  }
}