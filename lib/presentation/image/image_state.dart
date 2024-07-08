import '../../data/model/image_item.dart';

class ImageState {
  List<ImageItem> imageItem;
  bool isLoading = false;

//<editor-fold desc="Data Methods">
  ImageState({
    required this.imageItem,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageState &&
          runtimeType == other.runtimeType &&
          imageItem == other.imageItem &&
          isLoading == other.isLoading);

  @override
  int get hashCode => imageItem.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'ImageState{' +
        ' imageItem: $imageItem,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  ImageState copyWith({
    List<ImageItem>? imageItem,
    bool? isLoading,
  }) {
    return ImageState(
      imageItem: imageItem ?? this.imageItem,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageItem': this.imageItem,
      'isLoading': this.isLoading,
    };
  }

  factory ImageState.fromJson(Map<String, dynamic> json) {
    return ImageState(
      imageItem: json['imageItem'] as List<ImageItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}