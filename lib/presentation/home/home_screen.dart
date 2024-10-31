import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildAppIcon(context, Icons.search, '이미지 검색', '/pixabayScreen'),
            _buildAppIcon(context, Icons.photo, '갤러리', '/gallery'),
            _buildAppIcon(context, Icons.settings, '설정', '/settings'),
            _buildAppIcon(context, Icons.person, '내 프로필', '/ProfileScreen'),
            _buildAppIcon(context, Icons.notifications, '알림', '/notifications'),
            _buildAppIcon(context, Icons.help, '도움말', '/help'),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        context.go(route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.cyan,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
