import '../../data/model/pixabay_item.dart';

class PixabayState {
  bool isLoadiing = false;
  List<PixabayItem> pixabayItem;

//<editor-fold desc="Data Methods">
  PixabayState({
    required this.isLoadiing,
    required this.pixabayItem,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PixabayState &&
          runtimeType == other.runtimeType &&
          isLoadiing == other.isLoadiing &&
          pixabayItem == other.pixabayItem);

  @override
  int get hashCode => isLoadiing.hashCode ^ pixabayItem.hashCode;

  @override
  String toString() {
    return 'PixabayState{' +
        ' isLoadiing: $isLoadiing,' +
        ' pixabayItem: $pixabayItem,' +
        '}';
  }

  PixabayState copyWith({
    bool? isLoadiing,
    List<PixabayItem>? pixabayItem,
  }) {
    return PixabayState(
      isLoadiing: isLoadiing ?? this.isLoadiing,
      pixabayItem: pixabayItem ?? this.pixabayItem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoadiing': this.isLoadiing,
      'pixabayItem': this.pixabayItem,
    };
  }

  factory PixabayState.fromJson(Map<String, dynamic> json) {
    return PixabayState(
      isLoadiing: json['isLoadiing'] as bool,
      pixabayItem: json['pixabayItem'] as List<PixabayItem>,
    );
  }

//</editor-fold>
}