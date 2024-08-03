import 'package:flutter/material.dart';

import '../../domain/model/pixabay_item.dart';

class PixbayWidget extends StatelessWidget {
  final PixabayItem pixabayItems;

  const PixbayWidget({super.key, required this.pixabayItems});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        pixabayItems.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
