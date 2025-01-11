import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  void _sendFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      query: 'subject=App Feedback ($_appName)&body=Write your feedback here...',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일 클라이언트를 열 수 없습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('앱 정보'),
            backgroundColor: _isDarkMode ? Colors.grey[900]! : Colors.cyan,
            elevation: 2,
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
                Tab(icon: Icon(Icons.featured_play_list), text: '앱 기능'),
                Tab(icon: Icon(Icons.person), text: '개발자 정보'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildAppInfoTab(),
              _buildFeaturesTab(),
              _buildDeveloperInfoTab(),
            ],
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
          _buildInfoTile('지원 플랫폼', 'iOS, Android'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _sendFeedback,
            icon: const Icon(Icons.email),
            label: const Text('피드백 보내기'),
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

  Widget _buildFeaturesTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildFeatureTile('다크 모드 지원', Icons.dark_mode),
        _buildFeatureTile('QR 코드 생성', Icons.qr_code),
        _buildFeatureTile('정보 공유 기능', Icons.share),
        _buildFeatureTile('피드백 전송', Icons.email),
      ],
    );
  }

  Widget _buildFeatureTile(String feature, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: _isDarkMode ? Colors.tealAccent : Colors.cyan),
        title: Text(
          feature,
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildDeveloperInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
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
          child: const Icon(Icons.info, size: 40, color: Colors.white),
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
