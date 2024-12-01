import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final List<Map<String, String>> _helpItems = [
    {'title': '이미지 검색', 'description': 'Pixabay에서 이미지를 검색하세요.'},
    {'title': '갤러리', 'description': '저장된 이미지를 확인하세요.'},
    {'title': '설정', 'description': '앱 설정을 변경하세요.'},
    {'title': '내 프로필', 'description': '프로필 정보를 관리하세요.'},
    {'title': '알림', 'description': '최신 알림을 확인하세요.'},
    {'title': '도움말', 'description': '앱 사용에 필요한 정보를 확인하세요.'},
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final filteredItems = _helpItems
        .where((item) =>
    item['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item['description']!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();

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
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : null,
          gradient: isDarkMode
              ? null
              : const LinearGradient(
            colors: [Colors.white, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 검색 입력 필드
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: '도움말 검색',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // 도움말 목록
              Expanded(
                child: filteredItems.isEmpty
                    ? Center(
                  child: Text(
                    '검색 결과가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color:
                      isDarkMode ? Colors.grey[800] : Colors.white,
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
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // 문의 및 FAQ 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('문의하기 화면으로 이동합니다.')),
                      );
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('FAQ 화면으로 이동합니다.')),
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}
