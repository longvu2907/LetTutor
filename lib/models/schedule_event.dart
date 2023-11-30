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
    int startTimestamp = json['startTimestamp'] ??
        json['scheduleDetailInfo']['startPeriodTimestamp'];
    int endTimestamp = json['endTimestamp'] ??
        json['scheduleDetailInfo']['endPeriodTimestamp'];

    return ScheduleEvent(
      id: json['scheduleDetailId'] ?? json['scheduleDetails'][0]['id'],
      start: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
      end: DateTime.fromMillisecondsSinceEpoch(endTimestamp),
      isBooked: json['isBooked'] ?? false,
    );
  }

  @override
  String toString() =>
      "${start.hour}:${start.minute} - ${end.hour}:${end.minute}";
}
