import 'package:dio/dio.dart';
import 'package:dwigasindo/const/const_api.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final dio = Dio();

  Future<void> loginService(String username, String password) async {
    try {
      final response = await dio.post("$baseUrl/login",
          data: {"username": username, "password": password});
      print(response.data);
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
