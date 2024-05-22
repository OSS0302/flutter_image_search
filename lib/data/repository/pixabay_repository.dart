
import 'package:flutter_image_search/data/model/pixabay_item.dart';

abstract interface class PixabayRepository {
  Future<List<PixabayItem>> getPixabayItem(String query);
}
