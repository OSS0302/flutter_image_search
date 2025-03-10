import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _alarms = [];
  final TextEditingController _alarmTitleController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadAlarms();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _alarmTitleController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String jsonData = json.encode(_alarms);
      await prefs.setString('alarms', jsonData);
    } catch (e) {
      debugPrint('알람 저장 오류: $e');
    }
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedAlarms = prefs.getString('alarms');
    if (savedAlarms != null) {
      try {
        final List<dynamic> decodedData = json.decode(savedAlarms);
        setState(() {
          _alarms.addAll(decodedData.map((e) {
            // repeatDays를 List<bool>로 변환
            final repeatDays = (e['repeatDays'] as List<dynamic>).map((day) => day as bool).toList();
            return {
              ...e,
              'repeatDays': repeatDays,
            };
          }));
        });
      } catch (e) {
        debugPrint('알람 로드 오류: $e');
        await prefs.remove('alarms');
      }
    }
  }

  void _addAlarm(
      TimeOfDay time, String title, List<bool> repeatDays) {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알람 제목을 입력하세요!')),
      );
      return;
    }

    final alarmText =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')} - $title';
    setState(() {
      _alarms.add({
        'text': alarmText,
        'title': title,
        'time': {'hour': time.hour, 'minute': time.minute},
        'enabled': true,
        'repeatDays': repeatDays,
      });
      _alarms.sort((a, b) {
        int hourComparison = a['time']['hour'].compareTo(b['time']['hour']);
        return hourComparison != 0
            ? hourComparison
            : a['time']['minute'].compareTo(b['time']['minute']);
      });
    });
    _saveAlarms();
    _alarmTitleController.clear();
  }

  void _toggleAlarm(int index) {
    setState(() {
      _alarms[index]['enabled'] = !_alarms[index]['enabled'];
    });
    _saveAlarms();
  }

  void _removeAlarm(int index) {
    setState(() {
      _alarms.removeAt(index);
    });
    _saveAlarms();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      List<bool> repeatDays = List.filled(7, false); // 요일 초기화

      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('알람 추가'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _alarmTitleController,
                        decoration: const InputDecoration(hintText: '알람 제목 입력'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '반복 요일 설정',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      ...List.generate(7, (index) {
                        return CheckboxListTile(
                          title: Text(['월', '화', '수', '목', '금', '토', '일'][index]),
                          value: repeatDays[index],
                          onChanged: (value) {
                            setState(() {
                              repeatDays[index] = value ?? false;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _addAlarm(picked, _alarmTitleController.text, repeatDays);
                    },
                    child: const Text('저장'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  Widget _buildAlarmCard(Map<String, dynamic> alarm, int index) {
    final time = alarm['time'];
    final formattedTime =
        '${time['hour'].toString().padLeft(2, '0')}:${time['minute'].toString().padLeft(2, '0')}';

    final repeatDays = alarm['repeatDays'] as List<bool>;
    final repeatDaysText = repeatDays.asMap().entries.where((e) => e.value).map((e) => ['월', '화', '수', '목', '금', '토', '일'][e.key]).join(', ');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Icon(
          alarm['enabled'] ? Icons.alarm : Icons.alarm_off,
          color: alarm['enabled'] ? Colors.tealAccent : Colors.grey,
        ),
        title: Text(
          alarm['title'],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '시간: $formattedTime\n반복: $repeatDaysText\n남은 시간: ${_calculateTimeRemaining(alarm['time'])}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: alarm['enabled'],
              onChanged: (value) => _toggleAlarm(index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeAlarm(index),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateTimeRemaining(Map<String, dynamic> time) {
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      time['hour'],
      time['minute'],
    );
    final difference = alarmTime.difference(now);

    if (difference.isNegative) {
      return '내일 ${time['hour']}:${time['minute'].toString().padLeft(2, '0')}';
    } else {
      return '${difference.inHours}시간 ${difference.inMinutes.remainder(60)}분 남음';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('알람 설정'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '활성'),
            Tab(text: '비활성'),
          ],

        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAlarmList(true),
          _buildAlarmList(false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectTime(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAlarmList(bool isActive) {
    final filteredAlarms =
    _alarms.where((alarm) => alarm['enabled'] == isActive).toList();

    if (filteredAlarms.isEmpty) {
      return Center(
        child: Text(
          isActive ? '활성화된 알람이 없습니다.' : '비활성화된 알람이 없습니다.',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredAlarms.length,
      itemBuilder: (context, index) {
        final alarm = filteredAlarms[index];
        return _buildAlarmCard(alarm, _alarms.indexOf(alarm));
      },
    );
  }
}
