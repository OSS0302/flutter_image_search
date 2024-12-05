import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '문의가 성공적으로 전송되었습니다. 감사합니다!',
            style: TextStyle(fontSize: 16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // 모든 입력 필드 초기화
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : LinearGradient(
            colors: [Colors.white, Colors.teal[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '문의 내용을 입력해주세요',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _nameController,
                  label: '이름',
                  hintText: '이름을 입력하세요',
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이름을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: '이메일',
                  hintText: '이메일 주소를 입력하세요',
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return '올바른 이메일 주소를 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _subjectController,
                  label: '제목',
                  hintText: '문의 제목을 입력하세요',
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '문의 제목을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _messageController,
                  label: '문의 내용',
                  hintText: '문의 내용을 입력하세요',
                  isDarkMode: isDarkMode,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '문의 내용을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _submitFeedback,
                    icon: const Icon(Icons.send, size: 20),
                    label: const Text(
                      '문의 전송',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isDarkMode ? Colors.tealAccent : Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required bool isDarkMode,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.tealAccent : Colors.cyan,
        ),
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black45,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colors.tealAccent : Colors.cyan,
          ),
        ),
      ),
    );
  }
}
