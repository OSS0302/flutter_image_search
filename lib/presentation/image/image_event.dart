import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_event.freezed.dart';

@freezed
sealed class ImageEvent<T> with _$ImageEvent<T> {
  const factory ImageEvent.showSnackBar(String message) = ShowSnackBar;
  const factory ImageEvent.showDialog(String message) = ShowDialog;
}