import 'package:http/http.dart' as http;
import 'dart:convert';
import '../json_models/home.dart';

class ApiClient {
  static final baseUrl = 'https://uapi.adrise.tv';
  final http.Client httpClient = http.Client();

  Map<String, String> _headers = {
    "Accept-Encoding": "deflate, gzip;q=1.0, *;q=0.5"
  };

  Future<HomeModel> fetchHomeModel() async {
    final url =
        '$baseUrl/matrix/homescreen?app_id=tubitv&device_id=3B17D64C-8A40-4234-A80E-0C3020F621B7&expand=2&limit=40&page_enabled=false&platform=iphone&user_id=0';
    final response = await this.httpClient.get(url, headers: _headers);
    if (response.statusCode != 200) {
      throw Exception('error getting home page data');
    }
    final json = jsonDecode(response.body);
    return HomeModel.fromJson(json);
  }
}
