import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../data/model/pixabay_item.dart';

part 'pixabay_state.freezed.dart';

part 'pixabay_state.g.dart';

@freezed
class PixabayState with _$PixabayState {
  const factory PixabayState({
    @Default([]) List<PixabayItem> pixabayItem,
    @Default(false) bool isLoading,

  }) = _PixabayState;

  factory PixabayState.fromJson(Map<String, Object?> json) => _$PixabayStateFromJson(json);
}