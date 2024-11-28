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
  final List<Map<String, dynamic>> _alarms = []; // 알림 리스트
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

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedAlarms = prefs.getString('alarms');
    if (savedAlarms != null) {
      setState(() {
        _alarms.addAll(List<Map<String, dynamic>>.from(json.decode(savedAlarms)));
      });
    }
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('alarms', json.encode(_alarms));
  }

  void _addAlarm(TimeOfDay? time) {
    if (time == null || _alarmController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('시간과 내용을 입력하세요!')),
      );
      return;
    }

    final alarmText =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')} - ${_alarmController.text}';
    setState(() {
      _alarms.add({
        'text': alarmText,
        'time': time,
        'enabled': true,
      });
      _alarms.sort((a, b) => a['time'].hour.compareTo(b['time'].hour)); // 시간순 정렬
    });
    _saveAlarms();
    _alarmController.clear();
  }

  void _removeAlarm(int index) {
    setState(() {
      _alarms.removeAt(index);
    });
    _saveAlarms();
  }

  void _toggleAlarm(int index) {
    setState(() {
      _alarms[index]['enabled'] = !_alarms[index]['enabled'];
    });
    _saveAlarms();
  }

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
        title: const Text('알림'),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.cyan,
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
      body: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : null,
          gradient: isDarkMode
              ? null
              : const LinearGradient(
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
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isDarkMode ? Colors.tealAccent : Colors.cyan,
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
                    final alarm = _alarms[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(
                          alarm['enabled']
                              ? Icons.alarm
                              : Icons.alarm_off,
                          color: alarm['enabled']
                              ? (isDarkMode
                              ? Colors.tealAccent
                              : Colors.cyan)
                              : Colors.grey,
                        ),
                        title: Text(
                          alarm['text'],
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: alarm['enabled'],
                              onChanged: (value) =>
                                  _toggleAlarm(index), // 알림 활성/비활성
                              activeColor: Colors.tealAccent,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: isDarkMode
                                    ? Colors.redAccent
                                    : Colors.red,
                              ),
                              onPressed: () => _removeAlarm(index),
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
