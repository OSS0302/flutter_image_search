import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';

class PixabayWidget extends StatelessWidget {
  final PixabayItem pixabayItem;
  const PixabayWidget({super.key, required this.pixabayItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(pixabayItem.imageUrl,fit: BoxFit.cover,),
    );
  }
}
