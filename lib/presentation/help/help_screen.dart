import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final Map<String, List<Map<String, String>>> _helpCategories = {
    '기능 사용법': [
      {'title': '이미지 검색', 'description': 'Pixabay에서 이미지를 검색하세요.'},
      {'title': '갤러리', 'description': '저장된 이미지를 확인하세요.'},
    ],
    '계정 관리': [
      {'title': '내 프로필', 'description': '프로필 정보를 관리하세요.'},
      {'title': '설정', 'description': '앱 설정을 변경하세요.'},
    ],
    '일반': [
      {'title': '알림', 'description': '최신 알림을 확인하세요.'},
      {'title': '도움말', 'description': '앱 사용에 필요한 정보를 확인하세요.'},
    ],
  };

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final filteredCategories = _helpCategories.map((category, items) {
      final filteredItems = items
          .where((item) =>
      item['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item['description']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
      return MapEntry(category, filteredItems);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('도움말'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Column(
        children: [
          // 검색 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: '도움말 검색',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 도움말 카테고리
          Expanded(
            child: ListView(
              children: filteredCategories.entries
                  .where((entry) => entry.value.isNotEmpty)
                  .map((entry) {
                final category = entry.key;
                final items = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: items
                            .map(
                              (item) => GestureDetector(
                            onTap: () {
                              _navigateToDetail(item);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.white,
                              elevation: 4,
                              child: ListTile(
                                leading: Icon(
                                  Icons.help_outline,
                                  color: isDarkMode
                                      ? Colors.tealAccent
                                      : Colors.cyan,
                                ),
                                title: Text(
                                  item['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                subtitle: Text(
                                  item['description']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          // 하단 버튼
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/contact');
                  },
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('문의하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isDarkMode ? Colors.tealAccent : Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push('/FAQScreen');
                  },
                  icon: const Icon(Icons.info_outline),
                  label: const Text('FAQ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isDarkMode ? Colors.tealAccent : Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelpDetailScreen(
          title: item['title']!,
          description: item['description']!,
        ),
      ),
    );
  }
}

class HelpDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  const HelpDetailScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
