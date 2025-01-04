import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  File? _selectedFile;
  bool _isSubmitting = false;
  bool _isAgreed = false;

  double _calculateProgress() {
    int filledFields = 0;
    if (_nameController.text.isNotEmpty) filledFields++;
    if (_emailController.text.isNotEmpty) filledFields++;
    if (_subjectController.text.isNotEmpty) filledFields++;
    if (_messageController.text.isNotEmpty) filledFields++;
    return filledFields / 4;
  }

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  void _submitFeedback() async {
    if (!_formKey.currentState!.validate() || !_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            '모든 필드를 작성하고 동의란에 체크해주세요.',
            style: TextStyle(fontSize: 16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    bool confirmed = await _showConfirmationDialog();
    if (!confirmed) return;

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          '문의가 성공적으로 전송되었습니다!',
          style: TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
    setState(() {
      _selectedFile = null;
      _isAgreed = false;
    });
  }

  Future<bool> _showConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('문의 전송 확인'),
          content: const Text('입력하신 문의를 전송하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('전송'),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
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
          padding: const EdgeInsets.all(16),
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
                LinearProgressIndicator(
                  value: _calculateProgress(),
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.teal[100],
                  color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _nameController,
                  label: '이름',
                  hintText: '이름을 입력하세요',
                  isDarkMode: isDarkMode,
                  validator: (value) => value == null || value.isEmpty
                      ? '이름을 입력해주세요.'
                      : null,
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
                  validator: (value) =>
                  value == null || value.isEmpty ? '문의 제목을 입력해주세요.' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _messageController,
                  label: '문의 내용',
                  hintText: '문의 내용을 입력하세요',
                  isDarkMode: isDarkMode,
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.isEmpty ? '문의 내용을 입력해주세요.' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('파일 첨부'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.tealAccent
                            : Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedFile != null)
                      Expanded(
                        child: Card(
                          elevation: 2,
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _selectedFile!.path.split('/').last,
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isAgreed,
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        '문의 전송 시 개인정보 수집에 동의합니다.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _submitFeedback,
                    icon: _isSubmitting
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                        : const Icon(Icons.send),
                    label: Text(
                      _isSubmitting ? '전송 중...' : '문의 전송',
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSubmitting
                          ? Colors.grey
                          : (isDarkMode ? Colors.tealAccent : Colors.cyan),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
      ),
    );
  }
}
