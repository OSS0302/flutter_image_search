
import 'package:image_search_app/data/mapper/pixabay_maepper.dart';

import '../../domain/model/pixabay_item.dart';
import '../../domain/repository/pixabay_repository.dart';
import '../core/result.dart';
import '../data_source/pixabay_api.dart';

class PixabayRepositoryImpl implements PixabayRepository {
  final _api = PixabayApi();

  @override
  Future<Result<List<PixabayItem>>> getPixabayItem(String query) async {
    try {
      final dto = await _api.getImageResult(query);
      if (dto.hits == null) {
        return Result.success([]);
      }
      return Result.success(dto.hits!.map((e) => e.toPixabayItem()).toList());
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

}