
import '../../domain/model/pixabay_item.dart';
import '../dto/pixabay_dto.dart';

extension DtoToModel on Hits {
  PixabayItem toPixabayItem() {
    return PixabayItem(
      imageUrl: previewURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
