import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/data/mapper/pixabay_mapper.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';
import 'package:image_search_app/data/repository/pixabay_respository.dart';

class PixabayRepositoryImpl implements PixabayRepository {

  final _api = PixabayAPi();

  @override
  Future<List<PixabayItem>> getPixabayItem(String query) async{
    final dto = await _api.getImageResult(query);
    if(dto.hits == null) {
      return [];
    }
    return dto.hits!.map((e) => e.toPixabayItem()).toList();
  }

}
