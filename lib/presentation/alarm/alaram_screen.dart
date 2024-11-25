import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<String> _alarms = []; // 알림 목록
  final TextEditingController _alarmController = TextEditingController(); // 입력 필드 컨트롤러

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  @override
  void dispose() {
    _alarmController.dispose();
    super.dispose();
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _alarms.addAll(prefs.getStringList('alarms') ?? []);
    });
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('alarms', _alarms);
  }

  void _addAlarm() {
    if (_alarmController.text.isNotEmpty) {
      setState(() {
        _alarms.add(_alarmController.text);
      });
      _saveAlarms(); // 알림 저장
      _alarmController.clear(); // 입력 필드 초기화
    }
  }

  void _removeAlarm(int index) {
    setState(() {
      _alarms.removeAt(index);
    });
    _saveAlarms(); // 알림 저장
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _addAlarmWithTime(picked);
    }
  }

  void _addAlarmWithTime(TimeOfDay time) {
    String alarmText = '알림: ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    setState(() {
      _alarms.add(alarmText);
    });
    _saveAlarms(); // 알림 저장
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Add back navigation functionality
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.black // 다크 모드: 단색 검정 배경
              : null, // 라이트 모드: 그라데이션 적용
          gradient: isDarkMode
              ? null // 다크 모드: 그라데이션 제거
              : const LinearGradient( // 라이트 모드: 기존 그라데이션
            colors: [Colors.white, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _alarmController,
                      decoration: InputDecoration(
                        hintText: '알림 내용을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _selectTime(context), // 시간 선택
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.tealAccent : Colors.cyan,
                    ),
                    child: const Text('시간 설정'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _alarms.isEmpty
                    ? Center(
                  child: Text(
                    '등록된 알림이 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: _alarms.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(
                          Icons.alarm,
                          color: isDarkMode ? Colors.tealAccent : Colors.cyan,
                        ),
                        title: Text(
                          _alarms[index],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: isDarkMode ? Colors.redAccent : Colors.red,
                          ),
                          onPressed: () => _removeAlarm(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
