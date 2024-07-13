import '../../data/model/pixabay_item.dart';

class PixabayState {
  List<PixabayItem> pixabayItem;

  bool isLoading = false;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.pixabayItem,
    required this.isLoading,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          pixabayItem == other.pixabayItem &&
          isLoading == other.isLoading);

  @override
  int get hashCode => pixabayItem.hashCode ^ isLoading.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' pixabayItem: $pixabayItem,' +
        ' isLoading: $isLoading,' +
        '}';
  }

  PixabayState copyWith({
    List<PixabayItem>? pixabayItem,
    bool? isLoading,
  }) {
    return PixabayState(
      pixabayItem: pixabayItem ?? this.pixabayItem,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pixabayItem': this.pixabayItem,
      'isLoading': this.isLoading,
    };
  }

  factory PixabayState.fromJson(Map<String, dynamic> json) {
    return PixabayState(
      pixabayItem: json['pixabayItem'] as List<PixabayItem>,
      isLoading: json['isLoading'] as bool,
    );
  }

//</editor-fold>
}