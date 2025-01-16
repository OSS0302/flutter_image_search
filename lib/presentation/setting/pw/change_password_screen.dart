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
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;
  String _passwordStrength = '';

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('성공'),
          content: const Text('비밀번호가 성공적으로 변경되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  void _checkPasswordStrength(String value) {
    String strength;
    if (value.isEmpty) {
      strength = '';
    } else if (value.length < 6) {
      strength = '약함';
    } else if (value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[0-9]'))) {
      strength = '강함';
    } else {
      strength = '보통';
    }

    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

    final backgroundColor = BoxDecoration(
      gradient: LinearGradient(
        colors: isDarkMode
            ? [const Color(0xFF121212), const Color(0xFF1E1E1E)]
            : [const Color(0xFF00BCD4), const Color(0xFF8E24AA)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

    final cardColor = isDarkMode ? Colors.grey[900] ?? Colors.black : Colors.grey[100] ?? Colors.white;
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
                      _buildPasswordField(
                        controller: _currentPasswordController,
                        label: '현재 비밀번호',
                        isObscure: _isObscureCurrent,
                        onVisibilityToggle: () {
                          setState(() {
                            _isObscureCurrent = !_isObscureCurrent;
                          });
                        },
                        textColor: textColor,
                        cardColor: cardColor,
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField(
                        controller: _newPasswordController,
                        label: '새 비밀번호',
                        isObscure: _isObscureNew,
                        onVisibilityToggle: () {
                          setState(() {
                            _isObscureNew = !_isObscureNew;
                          });
                        },
                        textColor: textColor,
                        cardColor: cardColor,
                        onChanged: _checkPasswordStrength,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '비밀번호 강도: $_passwordStrength',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _passwordStrength == '강함'
                              ? Colors.green
                              : (_passwordStrength == '보통'
                              ? Colors.orange
                              : Colors.red),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: '비밀번호 확인',
                        isObscure: _isObscureConfirm,
                        onVisibilityToggle: () {
                          setState(() {
                            _isObscureConfirm = !_isObscureConfirm;
                          });
                        },
                        textColor: textColor,
                        cardColor: cardColor,
                        validator: (value) {
                          if (value != _newPasswordController.text) {
                            return '비밀번호가 일치하지 않습니다.';
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isObscure,
    required VoidCallback onVisibilityToggle,
    required Color textColor,
    required Color cardColor,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: onVisibilityToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: cardColor,
        labelStyle: TextStyle(color: textColor),
      ),
      obscureText: isObscure,
      style: TextStyle(color: textColor),
      onChanged: onChanged,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return '$label을(를) 입력하세요.';
            }
            return null;
          },
    );
  }
}
