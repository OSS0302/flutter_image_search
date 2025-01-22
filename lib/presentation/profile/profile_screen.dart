import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isNotificationEnabled = true;
  bool _isDarkMode = false;
  bool _isExpandedView = true;

  String _userName = "사용자 이름";
  String _userEmail = "user@example.com";
  Color _backgroundColor = Colors.white;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 사진이 업데이트되었습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사진 선택 중 오류가 발생했습니다.')),
      );
    }
  }

  Future<void> _removeImage() async {
    setState(() {
      _profileImage = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('프로필 사진이 삭제되었습니다.')),
    );
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController(text: _userName);
        final emailController = TextEditingController(text: _userEmail);

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('프로필 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userName = nameController.text;
                  _userEmail = emailController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('프로필 정보가 저장되었습니다.')),
                );
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }

  void _changeBackgroundColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('배경 색상 변경'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.white),
                  title: Text('화이트'),
                  onTap: () {
                    setState(() {
                      _backgroundColor = Colors.white;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.blue[100]),
                  title: Text('블루'),
                  onTap: () {
                    setState(() {
                      _backgroundColor = Colors.blue[100]!;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.grey[200]),
                  title: Text('그레이'),
                  onTap: () {
                    setState(() {
                      _backgroundColor = Colors.grey[200]!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
          title: Text('내 프로필'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
              onPressed: _toggleDarkMode,
            ),
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: _changeBackgroundColor,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : NetworkImage(
                        'https://example.com/default_profile.png',
                      ) as ImageProvider,
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  _userName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  _userEmail,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 20),
                SwitchListTile(
                  title: Text('알림 설정'),
                  value: _isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                  secondary: Icon(Icons.notifications_active),
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('프로필 수정'),
                  onTap: _editProfile,
                ),
                ElevatedButton.icon(
                  onPressed: _removeImage,
                  icon: Icon(Icons.delete),
                  label: Text('사진 삭제'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isExpandedView = !_isExpandedView;
                    });
                  },
                  child: Text(_isExpandedView ? '미리보기 닫기' : '프로필 미리보기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
