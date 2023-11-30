import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/models/schedule_event.dart';

Future<int> getTotalLearningTime({required String accessToken}) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/call/total');

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['total'];
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<ScheduleEvent> getNextBooking({required String accessToken}) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/booking/next');

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return ScheduleEvent.fromJson(json.decode(response.body)['data'][0]);
  } else {
    throw (json.decode(response.body)['message']);
  }
}
