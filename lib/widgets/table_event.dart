import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/services/tutor.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class ScheduleTable extends StatefulWidget {
  final String tutorId;

  const ScheduleTable({
    super.key,
    required this.tutorId,
  });

  @override
  State<ScheduleTable> createState() => ScheduleTableState();
}

class ScheduleTableState extends State<ScheduleTable> {
  late final ValueNotifier<List<ScheduleEvent>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final _kEvents = LinkedHashMap<DateTime, List<ScheduleEvent>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void _bookSchedule(ScheduleEvent value) async {
    try {
      await bookSchedule(
        tutorId: widget.tutorId,
        accessToken: context.read<Auth>().accessToken.toString(),
        scheduleId: value.id,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(e.toString()),
      ));
    }
    getEvents();
  }

  void getEvents() async {
    try {
      List<ScheduleEvent> events = await getSchedules(
        tutorId: widget.tutorId,
        accessToken: context.read<Auth>().accessToken.toString(),
      );

      setState(() {
        _kEvents.clear();

        for (var event in events) {
          DateTime date =
              DateTime(event.start.year, event.start.month, event.start.day);

          if (_kEvents.containsKey(date)) {
            _kEvents[date]!.add(event);
          } else {
            _kEvents.addAll({
              date: [event]
            });
          }
        }

        for (var k in _kEvents.keys) {
          _kEvents[k]!.sort((a, b) => a.start.compareTo(b.start));
        }

        _selectedDay = _focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getEvents();
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<ScheduleEvent> _getEventsForDay(DateTime day) {
    return _kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<ScheduleEvent>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: _selectedEvents.value.isNotEmpty ? 250 : 0,
          child: ValueListenableBuilder<List<ScheduleEvent>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                      color: value[index].isBooked
                          ? Colors.black26
                          : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${value[index]}'),
                        Button(
                          text: 'Book',
                          onPressed: value[index].isBooked
                              ? null
                              : () => _bookSchedule(value[index]),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
