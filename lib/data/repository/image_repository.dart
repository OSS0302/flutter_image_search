import 'package:image_search_app/data/model/image_item.dart';

abstract  interface class ImageRepository {
  Future<List<ImageItem>> getImageItems(String query);
}