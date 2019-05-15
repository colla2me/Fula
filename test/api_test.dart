import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

Iterable<MapEntry<String, String>> _buildQueryParams({
  int results,
  int page,
  String seed,
  String gender,
  String password
}) sync* {
  if (results !=null) yield MapEntry('results', results.toString());
  if (password != null) yield MapEntry('password', password);
  if (seed != null) yield MapEntry('seed', seed);
  if (page != null) yield MapEntry('page', page.toString());
  if (gender != null) yield MapEntry('gender', gender.toString());
}

class Notice {
  int noticeId;
  String noticeTitle;
  String noticeContent;
  String noticeCreateTime;

  Notice({this.noticeId, this.noticeTitle, this.noticeContent, this.noticeCreateTime});

  Notice.fromJson(Map<String, dynamic> json)
  : noticeId = json['noticeId'],
    noticeTitle = json['noticeTitle'],
    noticeContent = json['noticeContent'],
    noticeCreateTime = json['noticeCreateTime'];
}

Future<List<Notice>> getNoticeboard() async {

  final uri = Uri.https('htk-beta-api.30days-tech.com', '/v1/app/notices');

  final response = await http.get(uri);
  final responseJson = json.decode(response.body);

  if (response.statusCode == 200) {
    final resultData =responseJson['resultData'] as List;
    return resultData.map((json) => Notice.fromJson(json)).toList();
  }

  throw Exception(responseJson);
}

void main() async {

  // final queryParams = Map.fromEntries(_buildQueryParams(
  //   results: 2019,
  //   page: 1,
  //   seed: 'd2eqe2fczx',
  //   // gender: 'man',
  //   // password: '30days'
  // ));

  List<Notice> notices = await getNoticeboard();
  print(notices);

  // print(queryParams);

}
