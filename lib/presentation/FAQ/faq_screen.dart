import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> _faqs = [
    {'category': '사용 방법', 'question': '이미지 검색은 어떻게 하나요?', 'answer': 'Pixabay 검색창에 키워드를 입력하세요.'},
    {'category': '갤러리', 'question': '갤러리에 이미지를 저장하려면?', 'answer': '저장 버튼을 눌러 이미지를 갤러리에 추가하세요.'},
    {'category': '설정', 'question': '알림을 설정하려면?', 'answer': '알림 화면에서 원하는 시간을 설정하세요.'},
    {'category': '사용 방법', 'question': '프로필 정보를 수정하려면?', 'answer': '프로필 화면에서 정보를 업데이트하세요.'},
    {'category': '설정', 'question': '앱 테마를 변경할 수 있나요?', 'answer': '설정 화면에서 테마를 라이트/다크 모드로 변경할 수 있습니다.'},
  ];

  String _selectedCategory = '전체';
  String _searchQuery = '';
  List<String> _favorites = [];

  List<Map<String, String>> get _filteredFAQs {
    return _faqs
        .where((faq) =>
    (_selectedCategory == '전체' || faq['category'] == _selectedCategory) &&
        faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _toggleFavorite(String question) {
    setState(() {
      if (_favorites.contains(question)) {
        _favorites.remove(question);
      } else {
        _favorites.add(question);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // 카테고리 필터
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('전체'),
                  _buildCategoryChip('사용 방법'),
                  _buildCategoryChip('갤러리'),
                  _buildCategoryChip('설정'),
                ],
              ),
            ),
          ),
          // 검색 입력 필드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'FAQ 검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // FAQ 목록
          Expanded(
            child: _filteredFAQs.isEmpty
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
              itemCount: _filteredFAQs.length,
              itemBuilder: (context, index) {
                final faq = _filteredFAQs[index];
                final isFavorite = _favorites.contains(faq['question']);
                return FAQCard(
                  question: faq['question']!,
                  answer: faq['answer']!,
                  isDarkMode: isDarkMode,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () => _toggleFavorite(faq['question']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        selectedColor: isDarkMode ? Colors.tealAccent : Colors.cyan,
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected
              ? (isDarkMode ? Colors.black : Colors.white)
              : (isDarkMode ? Colors.white70 : Colors.black87),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final String question;
  final String answer;
  final bool isDarkMode;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FAQCard({
    super.key,
    required this.question,
    required this.answer,
    required this.isDarkMode,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite
                    ? (isDarkMode ? Colors.tealAccent : Colors.redAccent)
                    : (isDarkMode ? Colors.white70 : Colors.black54),
              ),
              onPressed: onFavoriteToggle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
