import 'package:image_search_app/data/dto/pixabay_dto.dart';

import '../../domain/model/pixabay_item.dart';

extension DtoToModel on Hits {
  PixabayItem toPixabayItem() {
    return PixabayItem(
      imageUrl: previewURL ?? '',
      tags: tags ?? '',
      id: id as int,
    );
  }
}
