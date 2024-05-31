import '../../data/model/image_item.dart';

class ImageState {
  bool isLoading = false;
  List<ImageItem> imageItem;

//<editor-fold desc="Data Methods">
  ImageState({
    required this.isLoading,
    required this.imageItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          imageItem == other.imageItem);

  @override
  int get hashCode => isLoading.hashCode ^ imageItem.hashCode;

  @override
  String toString() {
    return 'ImageState{' +
        ' isLoading: $isLoading,' +
        ' imageItem: $imageItem,' +
        '}';
  }

  ImageState copyWith({
    bool? isLoading,
    List<ImageItem>? imageItem,
  }) {
    return ImageState(
      isLoading: isLoading ?? this.isLoading,
      imageItem: imageItem ?? this.imageItem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': this.isLoading,
      'imageItem': this.imageItem,
    };
  }

  factory ImageState.fromJson(Map<String, dynamic> json) {
    return ImageState(
      isLoading: json['isLoading'] as bool,
      imageItem: json['imageItem'] as List<ImageItem>,
    );
  }

//</editor-fold>
}