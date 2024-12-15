import 'package:flutter/material.dart';

import '../../../main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호가 변경되었습니다.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 다크모드 상태 가져오기
    final isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

    // 배경 색상 설정
    final backgroundColor = BoxDecoration(
      gradient: LinearGradient(
        colors: isDarkMode
            ? [const Color(0xFF121212), const Color(0xFF1E1E1E)] // 다크모드 색상
            : [const Color(0xFF00BCD4), const Color(0xFF8E24AA)], // 라이트모드 색상
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

    final cardColor = isDarkMode ? Colors.grey[900] : Colors.grey[100];
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 변경'),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.cyan,
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Container(
        decoration: backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Card(
                color: cardColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '새로운 비밀번호를 입력하세요',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _currentPasswordController,
                        decoration: InputDecoration(
                          labelText: '현재 비밀번호',
                          prefixIcon: Icon(Icons.lock, color: isDarkMode ? Colors.teal : Colors.cyan),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: cardColor,
                          labelStyle: TextStyle(color: textColor),
                        ),
                        style: TextStyle(color: textColor),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '현재 비밀번호를 입력하세요.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: '새 비밀번호',
                          prefixIcon: Icon(Icons.lock_outline, color: isDarkMode ? Colors.teal : Colors.cyan),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: cardColor,
                          labelStyle: TextStyle(color: textColor),
                        ),
                        style: TextStyle(color: textColor),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '새 비밀번호를 입력하세요.';
                          } else if (value.length < 6) {
                            return '비밀번호는 6자 이상이어야 합니다.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _changePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDarkMode ? Colors.teal : Colors.cyan,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            '비밀번호 변경',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
