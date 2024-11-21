import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? null // 다크 모드: 그라데이션 없음
              : const LinearGradient(
            colors: [Colors.white, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: isDarkMode ? Colors.black : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildAppIcon(context, Icons.search, '이미지 검색', '/pixabayScreen', isDarkMode),
              _buildAppIcon(context, Icons.photo, '갤러리', '/gallery', isDarkMode),
              _buildAppIcon(context, Icons.settings, '설정', '/settings', isDarkMode),
              _buildAppIcon(context, Icons.person, '내 프로필', '/ProfileScreen', isDarkMode),
              _buildAppIcon(context, Icons.notifications, '알림', '/alarmScreen', isDarkMode),
              _buildAppIcon(context, Icons.help, '도움말', '/helpScreen', isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppIcon(BuildContext context, IconData icon, String label, String route, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        context.go(route);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(1.05), // 터치 시 크기 증가
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          elevation: 8, // 그림자 효과를 더 부드럽게
          shadowColor: isDarkMode ? Colors.black54 : Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 56, // 아이콘 크기 조정
                color: isDarkMode ? Colors.tealAccent : Colors.cyan,
              ),
              const SizedBox(height: 8), // 간격 조정
              Text(
                label,
                style: TextStyle(
                  fontSize: 18, // 텍스트 크기 조정
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
