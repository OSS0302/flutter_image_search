import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = '한국어';
  final List<String> _languages = [
    '한국어',
    'English',
    'Español',
    '日本語',
    '中文',
    'Français',
    'Deutsch',
    'Italiano',
    'Português',
    'Русский'
  ];
  final Map<String, String> _languageFlags = {
    '한국어': '🇰🇷',
    'English': '🇺🇸',
    'Español': '🇪🇸',
    '日本語': '🇯🇵',
    '中文': '🇨🇳',
    'Français': '🇫🇷',
    'Deutsch': '🇩🇪',
    'Italiano': '🇮🇹',
    'Português': '🇵🇹',
    'Русский': '🇷🇺',
  };
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage') ?? '한국어';
    });
  }

  Future<void> _saveLanguagePreference(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    _saveLanguagePreference(language);
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
    final filteredLanguages = _languages
        .where((language) => language
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('언어 설정'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: isDarkMode ? Colors.grey[900] : Colors.teal[100],
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Text(
              '선택된 언어: $_selectedLanguage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.tealAccent : Colors.teal[800],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: '언어 검색...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLanguages.length,
              itemBuilder: (context, index) {
                final language = filteredLanguages[index];
                final isSelected = _selectedLanguage == language;

                return GestureDetector(
                  onTap: () => _changeLanguage(language),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDarkMode ? Colors.teal[800] : Colors.teal[100])
                          : (isDarkMode ? Colors.grey[850] : Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? (isDarkMode ? Colors.tealAccent : Colors.teal)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _languageFlags[language] ?? '🌐',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          language,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        if (isSelected)
                          const Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: isDarkMode
                                ? Colors.tealAccent
                                : Colors.teal,
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
    );
  }
}
