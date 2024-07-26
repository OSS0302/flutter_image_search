import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pixabay_item.freezed.dart';

part 'pixabay_item.g.dart';

@freezed
class PixabayItem with _$PixabayItem {
  const factory PixabayItem({
    required String imageUrl,
    required String tags,
    required int id,
  }) = _PixabayItem;

  factory PixabayItem.fromJson(Map<String, Object?> json) => _$PixabayItemFromJson(json);
}