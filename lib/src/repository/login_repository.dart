import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
/*
Future getAuthHeader() async {
  final preferences = await SharedPreferences.getInstance();
  var accessToken = preferences.getString('access_token');

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $accessToken"
  };
  return headers;
}



Future<String> login(token) async {
  var dio = Dio();
  var url = 'http://13.125.145.165:3000/authentication/login';

  try {
    var response = await dio.post(
      url,
      data: {
        'accessToken': token,
        'vendor': "kakao",
      },
    );

    if (response.statusCode == 201) {
      print("Response data: ${response.data}");
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('access_token', response.data['accessToken']);
      return response.data['accessToken'];
    } else {
      throw Exception('Failed to load profiles');
    }
  } catch (e) {
    //throw Exception('Error occurred: $e');
    print('Request URL: $url');
    if (e is DioError) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
    } else {
      print('Error occurred: $e');
    }
    return "error";
  }
}
*/