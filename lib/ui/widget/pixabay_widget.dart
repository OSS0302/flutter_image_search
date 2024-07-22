import 'package:flutter/material.dart';
import 'package:image_search_app/data/model/pixabay_item.dart';

class PixabayWidget extends StatelessWidget {
  final PixabayItem pixabayItems;
  const PixabayWidget({super.key, required this.pixabayItems});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(pixabayItems.imageUrl,fit: BoxFit.cover,),
    );
  }
}
