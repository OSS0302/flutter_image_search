import 'package:flutter_image_search/data/dto/pixabay_dto.dart';
import 'package:flutter_image_search/data/model/pixabay_item.dart';

extension DtoToModel on Hits {
  PixabayItem toPixabayItem() {
    return PixabayItem(
      imageUrl: previewURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
