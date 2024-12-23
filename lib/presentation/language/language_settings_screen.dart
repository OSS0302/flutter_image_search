import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = '한국어'; // 기본 언어 설정

  final List<String> _languages = ['한국어', 'English', 'Español', '日本語', '中文'];

  final ValueNotifier<String> _languageNotifier = ValueNotifier('한국어');

  @override
  void dispose() {
    _languageNotifier.dispose();
    super.dispose();
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _languageNotifier.value = language;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('언어가 "$language"(으)로 변경되었습니다.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '언어 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
            colors: [Colors.black, Colors.grey[850]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : LinearGradient(
            colors: [Colors.teal[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '언어를 선택하세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];
                  final isSelected = _selectedLanguage == language;

                  return GestureDetector(
                    onTap: () => _changeLanguage(language),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[850] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? (isDarkMode ? Colors.tealAccent : Colors.teal)
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: isDarkMode ? Colors.tealAccent.withOpacity(0.4) : Colors.teal.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            language,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: isDarkMode ? Colors.tealAccent : Colors.teal,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
