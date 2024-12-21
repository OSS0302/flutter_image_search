import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final languages = ['한국어', 'English', 'Español', '日本語', '中文'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('언어 설정', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? LinearGradient(
                colors: [Colors.black, Colors.grey[850]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
                  : LinearGradient(
                colors: [Colors.teal, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return _buildLanguageOption(
                context,
                language: languages[index],
                isSelected: index == 0, // 기본값: 첫 번째 언어가 선택됨
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('언어가 "${languages[index]}"(으)로 변경되었습니다.')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, {
        required String language,
        required bool isSelected,
        required VoidCallback onTap,
      }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
        border: Border.all(
          color: isSelected
              ? (isDarkMode ? Colors.tealAccent : Colors.teal)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        title: Text(
          language,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check, color: isDarkMode ? Colors.tealAccent : Colors.teal)
            : null,
        onTap: onTap,
      ),
    );
  }
}
