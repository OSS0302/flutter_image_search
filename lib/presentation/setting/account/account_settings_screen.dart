import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('계정 설정', style: TextStyle(fontWeight: FontWeight.bold)),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  _buildSettingOption(
                    context,
                    icon: Icons.person,
                    title: '프로필 사진 변경',
                    subtitle: '사진을 업데이트하세요',
                    onTap: () {
                      // TODO: Add functionality to change profile picture
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    context,
                    icon: Icons.edit,
                    title: '이름 변경',
                    subtitle: '계정 이름을 변경합니다',
                    onTap: () {
                      // TODO: Add functionality to change name
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    context,
                    icon: Icons.email,
                    title: '이메일 변경',
                    subtitle: '연락처 이메일을 수정하세요',
                    onTap: () {
                      // TODO: Add functionality to change email
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    context,
                    icon: Icons.password,
                    title: '비밀번호 변경',
                    subtitle: '비밀번호를 업데이트하세요',
                    onTap: () {
                      // TODO: Add functionality to change password
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    context,
                    icon: Icons.delete_forever,
                    title: '계정 삭제',
                    subtitle: '계정을 삭제하려면 눌러주세요',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('계정 삭제'),
                          content: const Text('정말 계정을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Add functionality to delete account
                                Navigator.pop(context);
                              },
                              child: const Text('삭제', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.teal[100],
          child: Icon(icon, color: isDarkMode ? Colors.white : Colors.teal, size: 28),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        onTap: onTap,
      ),
    );
  }
}
