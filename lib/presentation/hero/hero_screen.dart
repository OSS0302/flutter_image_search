import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/image_item.dart';

class HeroScreen extends StatelessWidget {
  final ImageItem imageItem;

  const HeroScreen({super.key, required this.imageItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageItem.tags),
      ),
      body: Hero(
          tag: imageItem.id,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageItem.imageUrl,
                fit: BoxFit.cover,
                width: 400,
                height: 400,
              ),
            ),
          )),
    );
  }
}
