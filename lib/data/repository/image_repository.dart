import '../model/image_item.dart';

abstract interface class  ImageRepository {
  Future<List<ImageItem>> getImageResult(String query);
}