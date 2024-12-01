import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // FAQ 항목 리스트
    final List<Map<String, String>> faqs = [
      {'question': '이미지 검색은 어떻게 하나요?', 'answer': 'Pixabay 검색창에 키워드를 입력하세요.'},
      {'question': '갤러리에 이미지를 저장하려면?', 'answer': '저장 버튼을 눌러 이미지를 갤러리에 추가하세요.'},
      {'question': '알림을 설정하려면 어떻게 해야 하나요?', 'answer': '알림 화면에서 원하는 시간을 설정하세요.'},
      {'question': '프로필 정보를 수정하려면?', 'answer': '프로필 화면에서 정보를 업데이트하세요.'},
      {'question': '앱 테마를 변경할 수 있나요?', 'answer': '설정 화면에서 테마를 라이트/다크 모드로 변경할 수 있습니다.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
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
          child: ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return FAQCard(
                question: faq['question']!,
                answer: faq['answer']!,
                isDarkMode: isDarkMode,
              );
            },
          ),
        ),
      ),
    );
  }
}

class FAQCard extends StatefulWidget {
  final String question;
  final String answer;
  final bool isDarkMode;

  const FAQCard({
    super.key,
    required this.question,
    required this.answer,
    required this.isDarkMode,
  });

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: widget.isDarkMode ? Colors.grey[800] : Colors.white,
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            trailing: Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: widget.isDarkMode ? Colors.tealAccent : Colors.cyan,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
