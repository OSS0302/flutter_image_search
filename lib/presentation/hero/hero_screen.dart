import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 로컬 저장소용
import 'package:image_search_app/domain/model/pixabay_item.dart';

class HeroScreen extends StatefulWidget {
  final PixabayItem pixabayItem;

  const HeroScreen({super.key, required this.pixabayItem});

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  bool isLiked = false; // 좋아요 상태

  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
  }

  // 로컬 저장소에서 좋아요 상태 불러오기
  Future<void> _loadLikeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool(widget.pixabayItem.imageUrl) ?? false;
    });
  }

  // 로컬 저장소에 좋아요 상태 저장
  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = !isLiked;
      prefs.setBool(widget.pixabayItem.imageUrl, isLiked);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.pixabayItem.imageUrl;
    final String tags = widget.pixabayItem.tags;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('이미지 상세 보기'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 100, color: Colors.red),
                );
              },
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 메인 이미지
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
                const SizedBox(height: 20),
                // 좋아요 버튼
                IconButton(
                  onPressed: _toggleLike,
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                // 정보 표시
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tags,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // 관련 이미지 보기
                const Text(
                  '관련 이미지',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // 임시 개수
                    itemBuilder: (context, index) {
                      // 실제로는 관련 이미지를 API에서 받아와야 함
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
