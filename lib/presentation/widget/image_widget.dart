import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/image_item.dart';

class ImageWidget extends StatelessWidget {
  final ImageItem imageItem;
  const ImageWidget({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(imageItem.imageUrl,fit: BoxFit.cover,),
    );
  }
}
