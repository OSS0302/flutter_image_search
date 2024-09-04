import 'package:image_search_app/data/model/pixabay_item.dart';

import '../../core/result.dart';

abstract interface class PixabayRepository {
  Future<Result<List<PixabayItem>>> getImageResult(String query);
}