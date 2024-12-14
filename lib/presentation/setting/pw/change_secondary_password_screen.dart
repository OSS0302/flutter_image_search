import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangeSecondaryPasswordScreen extends StatefulWidget {
  const ChangeSecondaryPasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangeSecondaryPasswordScreenState createState() => _ChangeSecondaryPasswordScreenState();
}

class _ChangeSecondaryPasswordScreenState extends State<ChangeSecondaryPasswordScreen> {
  final TextEditingController _secondaryPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _passwordStrength = "";

  @override
  void dispose() {
    _secondaryPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changeSecondaryPassword() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('2차 비밀번호가 변경되었습니다.')),
      );
      context.pop();
    }
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        _passwordStrength = "";
      } else if (password.length < 6) {
        _passwordStrength = "약함";
      } else if (password.contains(RegExp(r'[0-9]')) && password.contains(RegExp(r'[A-Za-z]'))) {
        _passwordStrength = "보통";
      } else if (password.length >= 8 && password.contains(RegExp(r'[!@#\$&*~]'))) {
        _passwordStrength = "강함";
      } else {
        _passwordStrength = "약함";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2차 비밀번호 변경'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004D40), Color(0xFF80CBC4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '새로운 2차 비밀번호를 입력하세요',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _secondaryPasswordController,
                        decoration: InputDecoration(
                          labelText: '2차 비밀번호',
                          prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        obscureText: true,
                        onChanged: _checkPasswordStrength,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '2차 비밀번호를 입력하세요.';
                          } else if (value.length < 6) {
                            return '2차 비밀번호는 6자 이상이어야 합니다.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '비밀번호 강도: $_passwordStrength',
                        style: TextStyle(
                          color: _passwordStrength == "강함" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: '비밀번호 확인',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.teal),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 확인을 입력하세요.';
                          } else if (value != _secondaryPasswordController.text) {
                            return '비밀번호가 일치하지 않습니다.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _changeSecondaryPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            '2차 비밀번호 변경',
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
