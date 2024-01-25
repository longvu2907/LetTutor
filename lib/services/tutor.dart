import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/config/env_config.dart';
import 'package:lettutor/models/review.dart';
import 'package:lettutor/models/schedule_event.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/models/user.dart';

class TutorFilters {
  DateTime? date;
  Object nationality;
  List<String> specialties;
  List<DateTime?> tutoringTimeAvailable;

  TutorFilters({
    this.date,
    this.nationality = const {},
    this.specialties = const [],
    this.tutoringTimeAvailable = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      "nationality": nationality,
      "specialties": specialties,
      "tutoringTimeAvailable": tutoringTimeAvailable,
    };
  }
}

class TutorSearchQuery {
  TutorFilters? filters;
  int page;
  int perPage;
  String? search;

  TutorSearchQuery({
    this.page = 1,
    this.perPage = 5,
    TutorFilters? filters,
    this.search,
  }) {
    this.filters = filters ?? TutorFilters();
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'perPage': perPage,
      'filters': filters?.toJson(),
      'search': search ?? "",
    };
  }
}

Future<List<User>> getTutorList({
  TutorSearchQuery? query,
  required String accessToken,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/tutor/search');

  var response = await post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode(query ?? TutorSearchQuery()),
  );

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body)['rows'];
    List<User> res = List<User>.from(l.map((e) => User.fromJson(e)));

    return res;
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<Tutor> getTutor({
  required String tutorId,
  required String accessToken,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/tutor/$tutorId');

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    return Tutor.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<List<ReviewModel>> getReviews({
  required String tutorId,
  required String accessToken,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/feedback/v2/$tutorId');

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body)['data']['rows'];
    List<ReviewModel> res =
        List<ReviewModel>.from(l.map((e) => ReviewModel.fromJson(e)));

    return res;
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<List<ScheduleEvent>> getSchedules({
  required String tutorId,
  required String accessToken,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/schedule', {
    'tutorId': tutorId,
    'page': "0",
  });

  var response = await get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
  );

  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body)['scheduleOfTutor'];
    List<ScheduleEvent> res =
        List<ScheduleEvent>.from(l.map((e) => ScheduleEvent.fromJson(e)));

    return res;
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<void> bookSchedule({
  required String tutorId,
  required String accessToken,
  required String scheduleId,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/booking');

  var response = await post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode({
      'scheduleDetailIds': [scheduleId],
    }),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw (json.decode(response.body)['message']);
  }
}

Future<void> manageFavoriteTutor({
  required String tutorId,
  required String accessToken,
}) async {
  var url = Uri.https(EnvConfig.baseUrl, '/user/manageFavoriteTutor');

  var response = await post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode({
      'tutorId': tutorId,
    }),
  );

  if (response.statusCode == 200) {
    return;
  } else {
    throw (json.decode(response.body)['message']);
  }
}
