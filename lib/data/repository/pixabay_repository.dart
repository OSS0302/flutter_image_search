import '../model/pixabay_item.dart';

abstract interface class PixabayRepository {
  Future<List<PixabayItem>> getPixabayItem(String query);
}