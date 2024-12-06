import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 정보'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoTile('앱 이름', _appName, isDarkMode),
              const SizedBox(height: 16),
              _buildInfoTile('패키지 이름', _packageName, isDarkMode),
              const SizedBox(height: 16),
              _buildInfoTile('버전', '$_version (Build $_buildNumber)', isDarkMode),
              const SizedBox(height: 16),
              _buildInfoTile(
                '라이선스',
                '오픈소스 라이선스 정보 보기',
                isDarkMode,
                onTap: () {
                  showLicensePage(
                    context: context,
                    applicationName: _appName,
                    applicationVersion: '$_version (Build $_buildNumber)',
                  );
                },
              ),
              const Spacer(),
              Center(
                child: Text(
                  '© 2024 My App. All rights reserved.',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, bool isDarkMode,
      {VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.tealAccent : Colors.cyan,
        ),
      ),
      subtitle: Text(
        value.isEmpty ? '정보를 가져오는 중...' : value,
        style: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black87,
        ),
      ),
      trailing: onTap != null
          ? Icon(
        Icons.arrow_forward_ios,
        color: isDarkMode ? Colors.white70 : Colors.black54,
      )
          : null,
      onTap: onTap,
    );
  }
}
