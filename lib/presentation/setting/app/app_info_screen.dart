import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAppInfo();
  }

  Future<void> _fetchAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    await Future.delayed(const Duration(seconds: 1)); // 로딩 효과
    setState(() {
      _appName = info.appName;
      _packageName = info.packageName;
      _version = info.version;
      _buildNumber = info.buildNumber;
      _isLoading = false;
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
      theme: _isDarkMode ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('앱 정보'),
            backgroundColor: _isDarkMode ? Colors.grey[900]! : Colors.cyan!,
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
            bottom: TabBar(
              indicator: BoxDecoration(
                color: _isDarkMode ? Colors.tealAccent.withOpacity(0.2) : Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: const [
                Tab(icon: Icon(Icons.info), text: '앱 정보'),
                Tab(icon: Icon(Icons.person), text: '개발자 정보'),
              ],
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: TabBarView(
              key: ValueKey<bool>(_isDarkMode),
              children: [
                _buildAppInfoTab(),
                _buildDeveloperInfoTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppInfoTab() {
    return _isLoading
        ? Center(
      child: CircularProgressIndicator(
        color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
      ),
    )
        : SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
            '오픈소스 라이선스 보기',
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: _appName,
                applicationVersion: '$_version (Build $_buildNumber)',
              );
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Share.share('앱 이름: $_appName\n버전: $_version (Build $_buildNumber)');
            },
            icon: const Icon(Icons.share),
            label: const Text('앱 정보 공유'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isDarkMode ? Colors.tealAccent : Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
          const SizedBox(height: 16),
          QrImageView(
            data: '앱 이름: $_appName\n버전: $_version (Build $_buildNumber)',
            size: 150,
            backgroundColor: _isDarkMode ? Colors.grey[800]! : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildContactCard(
            title: '개발자 이메일',
            value: 'developer@example.com',
            icon: Icons.email,
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            title: '웹사이트',
            value: 'https://example.com',
            icon: Icons.web,
          ),
          const SizedBox(height: 16),
          _buildContactCard(
            title: '고객 지원 전화',
            value: '+82-10-1234-5678',
            icon: Icons.phone,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                onPressed: () => _launchURL('https://facebook.com'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                onPressed: () => _launchURL('https://twitter.com'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                onPressed: () => _launchURL('https://instagram.com'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: _isDarkMode ? Colors.teal[700]! : Colors.teal[100]!,
          child: ClipOval(
            child: Image.network(
              'https://example.com/image.png',
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
                '앱의 세부 정보와 개발자 정보를 확인하세요.',
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

  Widget _buildContactCard({required String title, required String value, required IconData icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: _isDarkMode ? Colors.grey[800]! : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: _isDarkMode ? Colors.tealAccent : Colors.cyan),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            color: _isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.copy,
          color: _isDarkMode ? Colors.tealAccent : Colors.cyan,
        ),
        onTap: () {
          Clipboard.setData(ClipboardData(text: value));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title 복사 완료')),
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
        color: _isDarkMode ? Colors.grey[800]! : Colors.white,
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
}
