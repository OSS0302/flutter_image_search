import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  String _appName = '';
  String _packageName = '';
  String _version = '';
  String _buildNumber = '';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _fetchAppInfo();
  }

  Future<void> _fetchAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appName = info.appName;
      _packageName = info.packageName;
      _version = info.version;
      _buildNumber = info.buildNumber;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('앱 정보'),
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.cyan,
          elevation: 2,
          leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (Navigator.canPop(context)) {
            context.pop(context);
          } else {
            context.go('/ProfileScreen');
          }
        },
      ),
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: _isDarkMode
                ? const LinearGradient(
              colors: [Colors.black, Colors.grey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
                : const LinearGradient(
              colors: [Colors.white, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildInfoTile('앱 이름', _appName),
                const SizedBox(height: 16),
                _buildInfoTile('패키지 이름', _packageName),
                const SizedBox(height: 16),
                _buildInfoTile('버전', '$_version (Build $_buildNumber)'),
                const SizedBox(height: 16),
                _buildInfoTile(
                  '라이선스',
                  '오픈소스 라이선스 정보 보기',
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: _appName,
                      applicationVersion: '$_version (Build $_buildNumber)',
                    );
                  },
                ),
                const SizedBox(height: 32),
                _buildSectionDivider(),
                const SizedBox(height: 16),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: _isDarkMode ? Colors.teal[700] : Colors.teal[100],
          child: ClipOval(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0mpEAFXv-iIa50q5rA2L6nnHGy_akXDFyQQ&s',
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.error,
                  color: _isDarkMode ? Colors.white : Colors.red,
                  size: 40,
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '앱 정보',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '앱에 대한 세부 정보 및 라이선스를 확인하세요.',
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String title, String value, {VoidCallback? onTap}) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title 복사 완료')),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: _isDarkMode ? Colors.grey[800] : Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
            ),
          ),
          subtitle: Text(
            value.isEmpty ? '정보를 가져오는 중...' : value,
            style: TextStyle(
              color: _isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          trailing: onTap != null
              ? Icon(
            Icons.arrow_forward_ios,
            color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
          )
              : null,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildSectionDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: _isDarkMode ? Colors.tealAccent : Colors.teal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '추가 정보',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: _isDarkMode ? Colors.tealAccent : Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text(
          '© 2024 My App. All rights reserved.\nDeveloped by My Team.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: _isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.email,
                color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
              ),
              onPressed: () {
                // 이메일 연결
              },
            ),
            IconButton(
              icon: Icon(
                Icons.web,
                color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
              ),
              onPressed: () {
                // 웹사이트 연결
              },
            ),
          ],
        ),
      ],
    );
  }
}
