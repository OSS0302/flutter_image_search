import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_item.freezed.dart';

part 'image_item.g.dart';

@freezed
class ImageItem with _$ImageItem {
  const factory ImageItem({
    required String imageUrl,
    required String tags,
    required int id,
  }) = _ImageItem;

  factory ImageItem.fromJson(Map<String, Object?> json) => _$ImageItemFromJson(json);
}