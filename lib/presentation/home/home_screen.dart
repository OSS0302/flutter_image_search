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
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : const LinearGradient(
            colors: [Colors.white, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 상단 최근 사용 메뉴
            _buildRecentMenu(context, isDarkMode),
            const SizedBox(height: 16),
            // 그리드 메뉴
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return _buildMenuCard(
                    context,
                    icon: item['icon'],
                    label: item['label'],
                    description: item['description'],
                    route: item['route'],
                    badgeCount: item['badgeCount'],
                    isDarkMode: isDarkMode,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 최근 사용 메뉴
  Widget _buildRecentMenu(BuildContext context, bool isDarkMode) {
    return GestureDetector(
      onTap: () => context.go('/recentScreen'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black54 : Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.history,
              size: 40,
              color: isDarkMode ? Colors.tealAccent : Colors.cyan,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '최근 사용',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    '가장 최근에 방문한 메뉴를 확인하세요.',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }

  // 그리드 메뉴 카드
  Widget _buildMenuCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String description,
        required String route,
        required bool isDarkMode,
        int? badgeCount,
      }) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black54
                      : Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (badgeCount != null && badgeCount > 0)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// 메뉴 데이터
final List<Map<String, dynamic>> _menuItems = [
  {
    'icon': Icons.search,
    'label': '이미지 검색',
    'description': '다양한 이미지를 검색하세요.',
    'route': '/pixabayScreen',
    'badgeCount': null,
  },
  {
    'icon': Icons.photo,
    'label': '갤러리',
    'description': '저장된 이미지를 확인하세요.',
    'route': '/gallery',
    'badgeCount': null,
  },
  {
    'icon': Icons.notifications,
    'label': '알림',
    'description': '새로운 알림을 확인하세요.',
    'route': '/alarmScreen',
    'badgeCount': 3,
  },
  {
    'icon': Icons.settings,
    'label': '설정',
    'description': '앱 환경설정을 변경하세요.',
    'route': '/settings',
    'badgeCount': null,
  },
  {
    'icon': Icons.person,
    'label': '내 프로필',
    'description': '프로필 정보를 확인하세요.',
    'route': '/profileScreen',
    'badgeCount': null,
  },
  {
    'icon': Icons.help,
    'label': '도움말',
    'description': '앱 사용 방법을 확인하세요.',
    'route': '/helpScreen',
    'badgeCount': null,
  },
];
