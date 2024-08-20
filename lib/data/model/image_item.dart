class ImageItem {
  final String imageUrl;
  final String tags;
  final int id;

//<editor-fold desc="Data Methods">
  const ImageItem({
    required this.imageUrl,
    required this.tags,
    required this.id,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageItem &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl &&
          tags == other.tags &&
          id == other.id);

  @override
  int get hashCode => imageUrl.hashCode ^ tags.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'ImageItem{' +
        ' imageUrl: $imageUrl,' +
        ' tags: $tags,' +
        ' id: $id,' +
        '}';
  }

  ImageItem copyWith({
    String? imageUrl,
    String? tags,
    int? id,
  }) {
    return ImageItem(
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': this.imageUrl,
      'tags': this.tags,
      'id': this.id,
    };
  }

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    return ImageItem(
      imageUrl: json['imageUrl'] as String,
      tags: json['tags'] as String,
      id: json['id'] as int,
    );
  }

//</editor-fold>
}