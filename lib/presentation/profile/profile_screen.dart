import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  String _userName = "사용자 이름";
  String _userEmail = "user@example.com";

  // 프로필 사진 변경 함수
  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _isLoading = false;
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  // 프로필 사진 삭제
  void _removeProfileImage() {
    setState(() {
      _profileImage = null;
    });
  }

  // 사용자 정보 수정 다이얼로그
  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController =
        TextEditingController(text: _userName);
        TextEditingController emailController =
        TextEditingController(text: _userEmail);

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('프로필 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userName = nameController.text;
                  _userEmail = emailController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('저장'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/');
            }
          },
        ),
        title: const Text('내 프로필'),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? null
              : const LinearGradient(
            colors: [Colors.teal, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: isDarkMode ? Colors.black87 : null,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 프로필 이미지
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider
                          : const NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbFQcO-4Xn3BmOajGASg21cqBAAQvPz7zYpw&s'),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'upload') {
                            _pickImageFromGallery();
                          } else if (value == 'remove') {
                            _removeProfileImage();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'upload',
                            child: Text('사진 변경'),
                          ),
                          const PopupMenuItem(
                            value: 'remove',
                            child: Text('사진 삭제'),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.cyan,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 사용자 이름
              Text(
                _userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              // 사용자 이메일
              Text(
                _userEmail,
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white70 : Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              // 프로필 수정 버튼
              ElevatedButton.icon(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit),
                label: const Text('프로필 수정'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 추가 정보 카드
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: Colors.cyan,
                  ),
                  title: const Text('추가 정보'),
                  subtitle: const Text('추가 프로필 정보를 입력하세요'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.push('/additional-info');
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


