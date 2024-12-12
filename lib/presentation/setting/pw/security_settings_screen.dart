import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _isTwoFactorEnabled = false;

  void _changePassword() {
    // 비밀번호 변경 로직
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('비밀번호 변경'),
          content: const Text('비밀번호를 변경하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 비밀번호 변경 처리
                Navigator.pop(context); // 예시: 처리 후 다이얼로그 닫기
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTwoFactorAuth(bool value) {
    setState(() {
      _isTwoFactorEnabled = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            _isTwoFactorEnabled ? '2단계 인증이 활성화되었습니다.' : '2단계 인증이 비활성화되었습니다.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('보안 설정'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isDarkMode),
            const SizedBox(height: 24),
            // 비밀번호 변경 카드
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.lock,
                    color: isDarkMode ? Colors.tealAccent : Colors.cyan),
                title: const Text('비밀번호 변경'),
                subtitle: const Text('현재 비밀번호를 변경합니다.'),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: isDarkMode ? Colors.tealAccent : Colors.cyan),
                onTap: _changePassword,
              ),
            ),
            const SizedBox(height: 16),
            // 2단계 인증 스위치 카드
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                value: _isTwoFactorEnabled,
                onChanged: _toggleTwoFactorAuth,
                secondary: Icon(Icons.security,
                    color: isDarkMode ? Colors.tealAccent : Colors.cyan),
                title: const Text('2단계 인증'),
                subtitle: const Text('계정을 더욱 안전하게 보호합니다.'),
              ),
            ),
            const SizedBox(height: 16),
            // 2차 비밀번호 변경 카드
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.vpn_key,
                    color: isDarkMode ? Colors.tealAccent : Colors.cyan),
                title: const Text('2차 비밀번호 변경'),
                subtitle: const Text('2단계 인증을 위한 비밀번호를 변경합니다.'),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: isDarkMode ? Colors.tealAccent : Colors.cyan),
                onTap: () {
                  context.push('/change-secondary-password'); // 라우팅 처리
                },
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                '보안 강화를 위해 주기적으로 비밀번호를 변경하세요.',
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isDarkMode ? Colors.teal[700] : Colors.teal[100],
          child: Icon(
            Icons.lock,
            size: 30,
            color: isDarkMode ? Colors.white : Colors.teal,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '보안 설정',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '계정을 안전하게 보호하세요.',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
