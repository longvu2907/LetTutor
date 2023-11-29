import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/models/user.dart';

class TutorFilters {
  final DateTime? date;
  final Object nationality;
  final List<String> specialties;
  final List<DateTime?> tutoringTimeAvailable;

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
  final int page;
  final int perPage;
  final String? search;

  TutorSearchQuery({
    this.page = 1,
    this.perPage = 50,
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
      'search': search,
    };
  }
}

Future<List<User>> getTutorList({
  TutorSearchQuery? query,
  required String accessToken,
}) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/tutor/search');

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

Future<User> getTutor({
  required String id,
  required String accessToken,
}) async {
  var url = Uri.https('sandbox.api.lettutor.com', '/tutor/$id');

  var response = await get(
    url,
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw (json.decode(response.body)['message']);
  }
}
