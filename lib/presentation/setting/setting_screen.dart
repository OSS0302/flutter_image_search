import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

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
            decoration: BoxDecoration(
              gradient: isDarkMode
                  ? null // 다크 모드에서는 단색 배경
                  : const LinearGradient(
                colors: [Colors.teal, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              color: isDarkMode
                  ? Colors.black54 // 다크 모드: 단색 검정 배경
                  : null, // 라이트 모드: 그라데이션 적용
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

  Widget _buildSettingsTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.black12
            : Theme
            .of(context)
            .cardColor, // 라이트 모드: 카드 테마 색상
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? Colors.white54 // 다크 모드: 흰색 테두리
              : Colors.black54, // 라이트 모드: teal 테두리
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: isDarkMode
              ? Colors.black54
              : Colors.black54,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors
                .black, // 다크 모드: 흰색, 라이트 모드: 검정
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black54, // 서브 타이틀 색상
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}