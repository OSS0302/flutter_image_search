
import '../dto/pixabay_dto.dart';
import '../model/pixabay_item.dart';

extension DtoToModel on Hits {
  PixabayItem toPixabayItem() {
    return PixabayItem(
      imageUrl: previewURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
