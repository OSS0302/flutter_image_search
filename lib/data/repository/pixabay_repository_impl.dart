import 'package:flutter_image_search/data/data_source/pixabay_api.dart';
import 'package:flutter_image_search/data/mapper/pixabay_maepper.dart';
import 'package:flutter_image_search/data/model/pixabay_item.dart';
import 'package:flutter_image_search/data/repository/pixabay_repository.dart';

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();

  @override
  Future<List<PixabayItem>> getPixabayItem(String query) async{
    final dto = await _api.getImageResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toPixabayItem()).toList();
  }

}