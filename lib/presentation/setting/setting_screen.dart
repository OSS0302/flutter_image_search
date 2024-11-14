import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('설정'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 100),
              _buildSettingsTile(
                context,
                icon: Icons.person,
                title: '계정 설정',
                subtitle: '프로필 정보 수정',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                context,
                icon: Icons.notifications,
                title: '알림 설정',
                subtitle: '푸시 알림 및 알림 사운드 관리',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                context,
                icon: Icons.lock,
                title: '보안 설정',
                subtitle: '비밀번호 및 2단계 인증 관리',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                context,
                icon: Icons.language,
                title: '언어 설정',
                subtitle: '앱 언어 변경',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                context,
                icon: Icons.palette,
                title: '테마 설정',
                subtitle: '라이트/다크 모드 전환',
                onTap: () {
                  MyApp.themeNotifier.value =
                  MyApp.themeNotifier.value == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
                },
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                context,
                icon: Icons.info,
                title: '앱 정보',
                subtitle: '버전 정보 및 라이선스',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.white54 : Colors.teal,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.teal.shade700,
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
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
