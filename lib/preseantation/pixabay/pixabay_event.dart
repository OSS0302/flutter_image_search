import 'package:freezed_annotation/freezed_annotation.dart';

part 'pixabay_event.freezed.dart';

@freezed
sealed class PixabayEvent<T> with _$PixabayEvent<T> {
  const factory PixabayEvent.showSnackBar(String message) = ShowSnackBar;
  const factory PixabayEvent.showDialog(String message) = ShowDialog;
}