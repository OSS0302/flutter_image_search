import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';

class ImageWidget extends StatelessWidget {
  final ImageItem imageItems;
  const ImageWidget({super.key, required this.imageItems});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(imageItems.imageUrl),
    );
  }
}
