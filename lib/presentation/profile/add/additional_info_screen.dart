import 'package:flutter/material.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  _AdditionalInfoScreenState createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveInfo() {
    if (_formKey.currentState!.validate()) {
      final additionalInfo = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      };
      Navigator.pop(context, additionalInfo);
      _showConfirmationDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 필드를 올바르게 입력하세요.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('저장 완료'),
          content: const Text('입력된 정보가 저장되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyan,
              ),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('추가 정보 입력'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 이름 입력
                _buildTextFormField(
                  controller: _nameController,
                  label: '이름',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이름을 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // 이메일 입력
                _buildTextFormField(
                  controller: _emailController,
                  label: '이메일',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력하세요.';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return '유효한 이메일 형식을 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // 전화번호 입력
                _buildTextFormField(
                  controller: _phoneController,
                  label: '전화번호',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '전화번호를 입력하세요.';
                    } else if (!RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
                      return '유효한 전화번호를 입력하세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // 버튼 그룹
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          '저장',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearForm,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDarkMode ? Colors.white70 : Colors.cyan,
                          side: BorderSide(
                            color: isDarkMode ? Colors.white70 : Colors.cyan,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          '초기화',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.cyan[50],
        prefixIcon: Icon(icon, color: isDarkMode ? Colors.white70 : Colors.cyan),
      ),
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
    );
  }
}
