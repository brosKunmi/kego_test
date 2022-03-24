// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:kego_test/services/api/dio_api.dart';
import 'package:kego_test/services/models/blog_model.dart';

class BlogService {
  static BlogService? _service;

  BlogService._();

  factory BlogService() => _service ??= BlogService._();

  static const String _url = 'https://jsonplaceholder.typicode.com/posts';

  final _dio = DioApi.createDio(_url);

  Future<List<Blog>?> getBlogs() async {
    Response response;

    List<Blog> blogs = [];

    response = await _dio.get(
      _dio.options.baseUrl,
      options: Options(responseType: ResponseType.plain),
    );

    if (response.statusCode == 200) {
      final List resBody = json.decode(response.data.toString());

      print(resBody);

      // final List resBody = [resB];

      blogs = resBody.map((e) => Blog.fromMap(e)).toList();

      return blogs;
    }
    return null;
  }

  Future addBlog(Blog blog) async {
    var res = await _dio.post(
      _dio.options.baseUrl,
      data: blog.toJson(),
      options: Options(
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    print(res.data);
  }

  Future deleteBlog(Blog blog) async {
    await _dio.delete(
      '${_dio.options.baseUrl}/${blog.id}',
    );
  }

  Future updateBlog(Blog blog) async {
    var res = await _dio.put(
      '${_dio.options.baseUrl}/${blog.id}',
      data: blog.toJson(),
    );

    print(res.data);
  }
}
