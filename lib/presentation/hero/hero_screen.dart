import 'package:flutter/material.dart';
import 'package:image_search_app/domain/model/pixabay_item.dart';

class HeroScreen extends StatelessWidget {
  final PixabayItem pixabayItem;

  const HeroScreen({super.key, required this.pixabayItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 현재 테마 정보 가져오기
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pixabayItem.tags,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black, // 다크모드 텍스트 색상
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan, // 다크모드에 맞춰 색상 설정
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: isDarkMode ? Colors.black87 : Colors.white,
                child: Image.network(
                  pixabayItem.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
    );
  }
}
