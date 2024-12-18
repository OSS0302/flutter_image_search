import 'dart:convert';
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
  final List<Map<String, dynamic>> _alarms = [];
  final TextEditingController _alarmController = TextEditingController();

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

  // 알람 저장
  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String jsonData = json.encode(_alarms);
      await prefs.setString('alarms', jsonData);
    } catch (e) {
      debugPrint('알람 데이터를 저장하는 중 오류가 발생했습니다: $e');
    }
  }

  // 알람 로드
  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedAlarms = prefs.getString('alarms');
    if (savedAlarms != null) {
      try {
        final List<dynamic> decodedData = json.decode(savedAlarms);
        setState(() {
          _alarms.addAll(decodedData.map((e) => Map<String, dynamic>.from(e)));
        });
      } catch (e) {
        debugPrint('알람 데이터를 로드하는 중 오류가 발생했습니다: $e');
        await prefs.remove('alarms');
      }
    }
  }

  // 알람 추가
  void _addAlarm(TimeOfDay time) {
    if (_alarmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알람 설명을 입력하세요!')),
      );
      return;
    }

    final alarmText =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')} - ${_alarmController.text}';
    setState(() {
      _alarms.add({
        'text': alarmText,
        'time': {'hour': time.hour, 'minute': time.minute},
        'enabled': true,
      });
      _alarms.sort((a, b) {
        int hourComparison = a['time']['hour'].compareTo(b['time']['hour']);
        return hourComparison != 0
            ? hourComparison
            : a['time']['minute'].compareTo(b['time']['minute']);
      });
    });
    _saveAlarms();
    _alarmController.clear();
  }

  // 알람 삭제 확인 다이얼로그
  void _confirmDeleteAlarm(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('알람 삭제'),
          content: const Text('이 알람을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _removeAlarm(index);
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  // 알람 삭제
  void _removeAlarm(int index) {
    setState(() {
      _alarms.removeAt(index);
    });
    _saveAlarms();
  }

  // 알람 상태 토글 (켜짐/꺼짐)
  void _toggleAlarm(int index) {
    setState(() {
      _alarms[index]['enabled'] = !_alarms[index]['enabled'];
    });
    _saveAlarms();
  }

  // 시간 선택 (시간 선택기 사용)
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _addAlarm(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('알람 설정'),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.black, Colors.grey[850]!]
                  : [Colors.white, Colors.blue[50]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 알람 설명 입력 필드와 시간 선택 버튼
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _alarmController,
                      decoration: InputDecoration(
                        hintText: '알람 설명을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? Colors.grey[800]
                            : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.tealAccent : Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    icon: const Icon(Icons.access_time),
                    label: const Text('시간 설정'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 알람 리스트
              Expanded(
                child: _alarms.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm_off,
                        size: 100,
                        color: isDarkMode ? Colors.white30 : Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '설정된 알람이 없습니다.',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: _alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = _alarms[index];
                    final time = alarm['time'];
                    final formattedTime =
                        '${time['hour'].toString().padLeft(2, '0')}:${time['minute'].toString().padLeft(2, '0')}';
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      elevation: 6,
                      child: ListTile(
                        leading: Icon(
                          alarm['enabled']
                              ? Icons.alarm
                              : Icons.alarm_off,
                          color: alarm['enabled']
                              ? (isDarkMode ? Colors.tealAccent : Colors.blueAccent)
                              : Colors.grey,
                        ),
                        title: Text(
                          '${alarm['text']} ($formattedTime)',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: alarm['enabled'],
                              onChanged: (value) => _toggleAlarm(index),
                              activeColor: Colors.tealAccent,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: isDarkMode ? Colors.redAccent : Colors.red,
                              ),
                              onPressed: () => _confirmDeleteAlarm(index), // 삭제 확인 다이얼로그
                            ),
                          ],
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
