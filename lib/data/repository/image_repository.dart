import '../model/image_item.dart';

abstract interface class ImageRepository {
  Future<List<ImageItem>> getImageItem(String query);
}