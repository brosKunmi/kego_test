// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kego_test/services/api/dio_api.dart';
import 'package:kego_test/services/models/user_model.dart';

class UserService {
  UserService._();

  factory UserService() => UserService._();

  final _dio = DioApi.createDio(_url);

  static const String _url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<Users>?> getUsers() async {
    Response response;

    List<Users> users = [];

    response = await _dio.get(_url,
        options: Options(responseType: ResponseType.plain));

    print(response.data);

    if (response.statusCode == 200) {
      print(response.statusCode);

      final List resBody = json.decode(response.data.toString());

      print('This is body ---> ${resBody.length}');

      users = resBody.map((e) => Users.fromMap(e)).toList();

      print('This is users length ---> ${users.length}');

      return users;
    }
    return null;
  }
}
