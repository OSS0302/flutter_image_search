import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> _faqs = [
    {'question': '이미지 검색은 어떻게 하나요?', 'answer': 'Pixabay 검색창에 키워드를 입력하세요.'},
    {'question': '갤러리에 이미지를 저장하려면?', 'answer': '저장 버튼을 눌러 이미지를 갤러리에 추가하세요.'},
    {'question': '알림을 설정하려면 어떻게 해야 하나요?', 'answer': '알림 화면에서 원하는 시간을 설정하세요.'},
    {'question': '프로필 정보를 수정하려면?', 'answer': '프로필 화면에서 정보를 업데이트하세요.'},
    {'question': '앱 테마를 변경할 수 있나요?', 'answer': '설정 화면에서 테마를 라이트/다크 모드로 변경할 수 있습니다.'},
  ];

  bool _expandAll = false;
  bool _isSorted = false;
  String _searchQuery = '';

  void _toggleExpandAll() {
    setState(() {
      _expandAll = !_expandAll;
    });
  }

  void _sortFAQs() {
    setState(() {
      if (!_isSorted) {
        _faqs.sort((a, b) => a['question']!.compareTo(b['question']!));
      } else {
        _faqs.shuffle(); // 원래 순서로 복구 (샘플 데이터라 임의 섞기)
      }
      _isSorted = !_isSorted;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // 검색 결과 필터링
    final filteredFAQs = _faqs
        .where((faq) => faq['question']!
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
        .toList();

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort_by_alpha,
              color: isDarkMode ? Colors.tealAccent : Colors.white,
            ),
            onPressed: _sortFAQs,
            tooltip: '정렬',
          ),
          IconButton(
            icon: Icon(
              _expandAll ? Icons.expand_less : Icons.expand_more,
              color: isDarkMode ? Colors.tealAccent : Colors.white,
            ),
            onPressed: _toggleExpandAll,
            tooltip: _expandAll ? '전체 접기' : '전체 펼치기',
          ),
        ],
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
                  hintText: 'FAQ 검색',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // FAQ 목록
              Expanded(
                child: filteredFAQs.isEmpty
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
                  itemCount: filteredFAQs.length,
                  itemBuilder: (context, index) {
                    final faq = filteredFAQs[index];
                    return FAQCard(
                      question: faq['question']!,
                      answer: faq['answer']!,
                      isDarkMode: isDarkMode,
                      expanded: _expandAll,
                    );
                  },
                ),
              ),
            ],
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
  final bool expanded;

  const FAQCard({
    super.key,
    required this.question,
    required this.answer,
    required this.isDarkMode,
    required this.expanded,
  });

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expanded;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (_isExpanded) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FAQCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded != oldWidget.expanded) {
      _isExpanded = widget.expanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}
