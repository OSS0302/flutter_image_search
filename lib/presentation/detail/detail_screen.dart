import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';

class DetailScreen extends StatelessWidget {
  final PixabayItem pixabayItem;

  const DetailScreen({super.key, required this.pixabayItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pixabayItem.tags),
      ),
      body: Hero(
        tag: pixabayItem.id,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              pixabayItem.imageUrl,
              fit: BoxFit.cover,
              width: 400,
              height: 400,
            ),
          ),
        ),
      ),
    );
  }
}
