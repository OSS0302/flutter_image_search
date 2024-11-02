import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        backgroundColor: Colors.cyan,
        elevation: 0,
        leading:  IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context); // 뒤로 가기 기능 추가
        } else {
          context.go('/'); // 홈 화면으로 이동
        }
      },
    ),

    ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.person,
            title: '계정 설정',
            subtitle: '프로필 정보 수정',
            onTap: () {
              // 계정 설정 화면으로 이동
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.notifications,
            title: '알림 설정',
            subtitle: '푸시 알림 및 알림 사운드 관리',
            onTap: () {
              // 알림 설정 화면으로 이동
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.lock,
            title: '보안 설정',
            subtitle: '비밀번호 및 2단계 인증 관리',
            onTap: () {
              // 보안 설정 화면으로 이동
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.language,
            title: '언어 설정',
            subtitle: '앱 언어 변경',
            onTap: () {
              // 언어 설정 화면으로 이동
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.palette,
            title: '테마 설정',
            subtitle: '라이트/다크 모드 전환',
            onTap: () {
              // 테마 설정 화면으로 이동
            },
          ),
          const SizedBox(height: 16),
          _buildSettingsTile(
            icon: Icons.info,
            title: '앱 정보',
            subtitle: '버전 정보 및 라이선스',
            onTap: () {
              // 앱 정보 화면으로 이동
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.cyan,
        child: Icon(icon, color: Colors.white, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: Colors.grey[200],
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
