
import '../../core/result.dart';
import '../model/pixabay_item.dart';

abstract interface class PixabayRepository {
  Future<Result<List<PixabayItem>>> getPixabayItems(String query);
}