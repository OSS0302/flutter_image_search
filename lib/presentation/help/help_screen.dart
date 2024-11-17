import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('도움말'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            context.go('/');
          }
        },
      ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '앱 도움말',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    '''
1. 이미지 검색
 - Pixabay를 통해 원하는 이미지를 검색할 수 있습니다.
 - 검색창에 키워드를 입력하고 다양한 이미지를 탐색해보세요.

2. 갤러리
 - 저장된 이미지를 갤러리에서 확인하세요.
 - 이미지를 삭제하거나 다른 작업을 수행할 수 있습니다.

3. 설정
 - 앱 테마, 알림 설정 등 다양한 옵션을 조정할 수 있습니다.

4. 내 프로필
 - 프로필 사진을 업로드하고 사용자 정보를 관리하세요.

5. 알림
 - 앱에서 제공하는 최신 소식을 받아보세요.

6. 도움말
 - 앱 사용에 필요한 정보를 이 화면에서 확인하세요.

궁금한 점이나 문제가 발생하면 언제든지 문의하세요. 즐거운 시간 보내세요!
                    ''',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
