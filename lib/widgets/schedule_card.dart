import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/pages/meeting_page.dart';
import 'package:lettutor/services/booking.dart';
import 'package:lettutor/widgets/button.dart';
import 'package:lettutor/widgets/custom_expansion_tile.dart';
import 'package:lettutor/widgets/snackbar_notify.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEvent schedule;
  final Function(bool cancelResult) onCancel;
  final jitsiMeet = JitsiMeet();

  ScheduleCard({
    super.key,
    required this.schedule,
    required this.onCancel,
  });

  void _joinMeeting(String room) async {
    var options = JitsiMeetConferenceOptions(configOverrides: {
      "startWithAudioMuted": true,
      "startWithVideoMuted": true,
      "subject": room,
    }, room: room);
    jitsiMeet.join(options);
  }

  bool _isTimeToJoin() {
    final now = DateTime.now();
    return now.isAfter(schedule.start) || now.isAtSameMomentAs(schedule.start);
  }

  @override
  Widget build(BuildContext context) {
    final String meetingToken =
        schedule.studentMeetingLink?.split('token=')[1] ?? '';
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    Future<String> handleCancelClass() async {
      final String token = context.read<Auth>().accessToken.toString();
      try {
        final result = await cancelBooked(
          scheduleDetailIds: [schedule.scheduleId ?? ""],
          accessToken: token,
        );

        return result;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(errorMessage(e.toString()));
        rethrow;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          // Schedule date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('E, dd MMM yy').format(schedule.start),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                '1 lesson',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          // Teacher info
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      schedule.tutor?.avatar ?? "",
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 5,
                  children: [
                    Text(
                      schedule.tutor?.name ?? "",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      '${Country.tryParse(schedule.tutor?.country ?? '')?.flagEmoji ?? ""} ${Country.tryParse(schedule.tutor?.country ?? '')?.name ?? schedule.tutor?.country}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chat,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Direct Message',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

          // Schedule time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                schedule.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Button(
                text: 'Cancel',
                onPressed: () async {
                  final dialogResult = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cancel class'),
                      content: const Text('Are you sure to cancel this class?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                  if (dialogResult) {
                    final result = await handleCancelClass();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(result),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (result == "Class Cancelled Successfully") {
                                onCancel(true);
                              }
                              Navigator.pop(context, false);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                color: ButtonColor.danger,
                type: ButtonType.outlined,
              )
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          const CustomExpansionTile(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                text: 'Go to meeting',
                onPressed: () async {
                  if (_isTimeToJoin()) {
                    _joinMeeting(room);
                  } else {
                    final result = await showWaitingRoomDialog(context);
                    if (result) {
                      _joinMeeting(room);
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MeetingPage(start: schedule.start);
                        },
                      ));
                    }
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<bool> showWaitingRoomDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('It is not the time yet'),
      content: const Text(
          'Do you want to enter meeting room right now, or enter waiting room?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Waiting Room'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Meeting Room'),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
