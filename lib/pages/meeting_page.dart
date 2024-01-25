import 'dart:async';

import 'package:flutter/material.dart';

class MeetingPage extends StatefulWidget {
  final DateTime start;

  const MeetingPage({Key? key, required this.start}) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  late Timer _timer;
  late Duration _currentTime;

  void _startTimer() {
    _currentTime = widget.start.difference(DateTime.now());

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_currentTime.inSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTime = widget.start.difference(DateTime.now());
          });
        }
      },
    );
  }

  String _convertWaitingTime() {
    final days = (_currentTime.inDays).toString().padLeft(2, '0');
    final hours = (_currentTime.inHours % (7)).toString().padLeft(2, '0');
    final minutes = (_currentTime.inMinutes % (24)).toString().padLeft(2, '0');
    final seconds = (_currentTime.inSeconds % (60)).toString().padLeft(2, '0');
    return '$days:$hours:$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    if (mounted) _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Lesson is starting in\n${_convertWaitingTime()}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
