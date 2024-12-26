import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _isNotificationsEnabled = true;
  bool _isSoundEnabled = true;
  bool _isVibrationEnabled = false;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 9, minute: 0);
  double _notificationPriority = 3.0; // 1~5 중요도
  final Map<String, bool> _notificationCategories = {
    "일반 알림": true,
    "소셜 알림": false,
    "마케팅 알림": false,
  };

  void _toggleNotifications(bool value) {
    setState(() {
      _isNotificationsEnabled = value;
    });
  }

  void _toggleSound(bool value) {
    setState(() {
      _isSoundEnabled = value;
    });
  }

  void _toggleVibration(bool value) {
    setState(() {
      _isVibrationEnabled = value;
    });
  }

  void _toggleCategory(String category, bool value) {
    setState(() {
      _notificationCategories[category] = value;
    });
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );
    if (pickedTime != null) {
      setState(() {
        _notificationTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
            colors: [Colors.black, Colors.grey[850]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : LinearGradient(
            colors: [Colors.teal[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 16),
            _buildSwitchTile(
              title: '푸시 알림',
              subtitle: '앱에서 알림을 받을지 설정합니다.',
              value: _isNotificationsEnabled,
              onChanged: _toggleNotifications,
            ),
            const SizedBox(height: 16),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isNotificationsEnabled ? 1.0 : 0.5,
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: '소리',
                    subtitle: '알림 소리를 활성화합니다.',
                    value: _isSoundEnabled,
                    onChanged: _toggleSound,
                    enabled: _isNotificationsEnabled,
                  ),
                  const SizedBox(height: 16),
                  _buildSwitchTile(
                    title: '진동',
                    subtitle: '알림 진동을 활성화합니다.',
                    value: _isVibrationEnabled,
                    onChanged: _toggleVibration,
                    enabled: _isNotificationsEnabled,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text(
                      '알림 시간 설정',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '알림 시간: ${_notificationTime.format(context)}',
                    ),
                    trailing: const Icon(Icons.access_time),
                    onTap: _isNotificationsEnabled
                        ? _selectNotificationTime
                        : null,
                    tileColor: _isNotificationsEnabled
                        ? (isDarkMode ? Colors.grey[800] : Colors.white)
                        : (isDarkMode ? Colors.grey[850] : Colors.grey[300]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPrioritySlider(),
                  const SizedBox(height: 16),
                  _buildCategorySelector(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final activeCategories = _notificationCategories.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '알림 설정 요약',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '활성화된 알림: ${activeCategories.join(', ')}',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            Text(
              '알림 중요도: ${_notificationPriority.toStringAsFixed(1)}/5',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '알림 중요도 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _notificationPriority,
          min: 1,
          max: 5,
          divisions: 4,
          label: _notificationPriority.toStringAsFixed(1),
          onChanged: _isNotificationsEnabled
              ? (value) {
            setState(() {
              _notificationPriority = value;
            });
          }
              : null,
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '알림 카테고리 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ..._notificationCategories.keys.map((category) {
          return CheckboxListTile(
            title: Text(category),
            value: _notificationCategories[category],
            onChanged: _isNotificationsEnabled
                ? (value) {
              if (value != null) {
                _toggleCategory(category, value);
              }
            }
                : null,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? (isDarkMode ? Colors.grey[800] : Colors.white)
            : (isDarkMode ? Colors.grey[850] : Colors.grey[300]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: enabled
              ? (isDarkMode ? Colors.tealAccent : Colors.teal)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: enabled
                ? (isDarkMode ? Colors.white : Colors.black)
                : (isDarkMode ? Colors.white38 : Colors.black38),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: enabled
                ? (isDarkMode ? Colors.white70 : Colors.black54)
                : (isDarkMode ? Colors.white38 : Colors.black38),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: enabled ? onChanged : null,
          activeColor: Colors.teal,
        ),
      ),
    );
  }
}
