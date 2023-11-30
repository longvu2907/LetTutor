class ScheduleEvent {
  final String id;
  final DateTime start;
  final DateTime end;
  final bool isBooked;

  const ScheduleEvent({
    required this.id,
    required this.start,
    required this.end,
    required this.isBooked,
  });

  factory ScheduleEvent.fromJson(Map<String, dynamic> json) {
    return ScheduleEvent(
      id: json['scheduleDetails'][0]['id'],
      start: DateTime.fromMillisecondsSinceEpoch(json['startTimestamp']),
      end: DateTime.fromMillisecondsSinceEpoch(json['endTimestamp']),
      isBooked: json['isBooked'],
    );
  }

  @override
  String toString() =>
      "${start.hour}:${start.minute} - ${end.hour}:${end.minute}";
}
