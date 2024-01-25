import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/config/env_config.dart';
import 'package:lettutor/models/schedule_event.dart';

Future<int> getTotalLearningTime({required String accessToken}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/call/total');

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
  var url = Uri.https(EnvConfig.baseUrl, '/booking/next');

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

class GetBookingQuery {
  int page;
  int perPage;

  GetBookingQuery({
    this.page = 1,
    this.perPage = 5,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'perPage': perPage,
    };
  }
}

Future<List<ScheduleEvent>> getBookings(
    {required String accessToken, GetBookingQuery? bookingQuery}) async {
  var query = bookingQuery ?? GetBookingQuery();
  var url = Uri.https(EnvConfig.baseUrl, '/booking/list/student', {
    "page": query.page.toString(),
    "perPage": query.perPage.toString(),
    "inFuture": "1",
    "orderBy": "meeting",
    "sortBy": "asc",
  });

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return json
        .decode(response.body)['data']['rows']
        .map<ScheduleEvent>((e) => ScheduleEvent.fromJson(e))
        .toList();
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<List<ScheduleEvent>> getBookingsHistory(
    {required String accessToken}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/booking/list/student', {
    "page": "1",
    "perPage": "20",
    "inFuture": "0",
    "orderBy": "meeting",
    "sortBy": "desc",
  });

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return json
        .decode(response.body)['data']['rows']
        .map<ScheduleEvent>((e) => ScheduleEvent.fromJson(e))
        .toList();
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<String> cancelBooked(
    {required List<String> scheduleDetailIds,
    required String accessToken}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/booking');

  var response = await delete(
    url,
    headers: {
      "Content-Type": "application/json;encoding=utf-8",
      "Authorization": "Bearer $accessToken",
    },
    body: json.encode(
      {
        'scheduleDetailIds': scheduleDetailIds,
      },
    ),
  );

  if (response.statusCode == 200) {
    return "Class Cancelled Successfully";
  }

  throw (json.decode(response.body)['message']);
}
