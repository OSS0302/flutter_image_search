import 'package:image_search_app/data/model/image_item.dart';

import '../../core/result.dart';

abstract interface class ImageRepository {
  Future<Result<List<ImageItem>>> getImageItems(String query);
}