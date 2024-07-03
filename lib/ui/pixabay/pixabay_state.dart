import '../../data/model/pixabay_item.dart';

class PixabayState {
  bool isLoading = false;
  List<PixabayItem> pixabayItem;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.isLoading,
    required this.pixabayItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          pixabayItem == other.pixabayItem);

  @override
  int get hashCode => isLoading.hashCode ^ pixabayItem.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' isLoading: $isLoading,' +
        ' pixabayItem: $pixabayItem,' +
        '}';
  }

  PixabayState copyWith({
    bool? isLoading,
    List<PixabayItem>? pixabayItem,
  }) {
    return PixabayState(
      isLoading: isLoading ?? this.isLoading,
      pixabayItem: pixabayItem ?? this.pixabayItem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': this.isLoading,
      'pixabayItem': this.pixabayItem,
    };
  }

  factory PixabayState.fromJson(Map<String, dynamic> json) {
    return PixabayState(
      isLoading: json['isLoading'] as bool,
      pixabayItem: json['pixabayItem'] as List<PixabayItem>,
    );
  }

//</editor-fold>
}
