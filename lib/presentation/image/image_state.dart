import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/image_item.dart';

part 'image_state.freezed.dart';

part 'image_state.g.dart';

@freezed
class ImageState with _$ImageState {
  const factory ImageState({
    @Default([]) List<ImageItem> imageItem,
    @Default(false) bool isLoading,
  }) = _ImageState;

  factory ImageState.fromJson(Map<String, Object?> json) => _$ImageStateFromJson(json);
}