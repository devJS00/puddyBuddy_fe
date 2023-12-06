import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

const _API_PREFIX =
    "http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/users";

class UserProvider with ChangeNotifier {
  Future<bool> userExists(String email) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
      "$_API_PREFIX/exists",
      queryParameters: {'email': email},
    );
    final result = (response.data)['result'];
    print(result);
    return result;
  }

  Future<Map<dynamic, dynamic>> getUserId(String email) async {
    Response response;
    Dio dio = new Dio();
    response = await dio
        .get("$_API_PREFIX/success", queryParameters: {'email': email});
    final result = (response.data)['result'];
    print(result);
    return result;
  }

  Future<int> getNewUserId(String email, String nickname) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/newuser",
        queryParameters: {'email': email, 'nickname': nickname});
    final result = (response.data)['result'];
    print(result);
    return result;
  }
}

UserProvider userProvider = UserProvider();
