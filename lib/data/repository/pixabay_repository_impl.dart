import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/pixabay_mapper.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_repository.dart';

import '../../core/result.dart';

class PixabayRepositoryImpl implements PixabayRepository{

  final _api = PixabayApi();

  @override
  Future<Result<List<PixabayItem>>> getPixabayItem(String query) async{
    try {
      final dto = await _api.getImageResult(query);
      if(dto.hits == null) {
        return Result.success([]);
      }
      return Result.success(dto.hits!.map((e) => e.toPixabayItem()).toList());
    }catch(e) {
      return Result.error(Exception(e.toString()));
    }

  }

}