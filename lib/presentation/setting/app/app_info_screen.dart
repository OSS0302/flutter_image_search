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
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
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
              _buildHeader(isDarkMode),
              const SizedBox(height: 24),
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
              const SizedBox(height: 32),
              _buildSectionDivider(isDarkMode),
              const SizedBox(height: 16),
              _buildFooter(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: isDarkMode ? Colors.teal[700] : Colors.teal[100],
          child: Icon(
            Icons.info,
            size: 40,
            color: isDarkMode ? Colors.white : Colors.teal,
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
                  color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '앱에 대한 세부 정보 및 라이선스를 확인하세요.',
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

  Widget _buildInfoTile(String title, String value, bool isDarkMode,
      {VoidCallback? onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          color: isDarkMode ? Colors.tealAccent : Colors.cyan,
        )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionDivider(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: isDarkMode ? Colors.tealAccent : Colors.teal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '추가 정보',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.tealAccent : Colors.cyan,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: isDarkMode ? Colors.tealAccent : Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(bool isDarkMode) {
    return Center(
      child: Text(
        '© 2024 My App. All rights reserved.\nDeveloped by My Team.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }
}
