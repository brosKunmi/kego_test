// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kego_test/services/models/user_model.dart';
import 'package:kego_test/services/repo/user_blog_repo.dart';

import '../services/models/blog_model.dart';

part 'userblog_state.dart';

class UserBlogCubit extends Cubit<UserBlogState> {
  UserBlogCubit() : super(UserBlogState());

  final _repo = UserBlogRepo();

  void getAllUsers() async {
    emit(state.copyWith(status: UserBlogStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      var _users = await _repo.getAllUsers();

      emit(
        state.copyWith(status: UserBlogStatus.loaded, users: _users),
      );
    } on DioError catch (e) {
      print(e.message);
      emit(state.copyWith(status: UserBlogStatus.error, error: e.message));
    }
  }

  void getUserBlog(int userId) async {
    emit(state.copyWith(status: UserBlogStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      var _blogs = await _repo.getAllBlogs();
      print(_blogs);

      var _userBlog =
          _blogs!.where((element) => element.userId == userId).toList();

      emit(
        state.copyWith(status: UserBlogStatus.loaded, blogs: _userBlog),
      );
    } on DioError catch (e) {
      print(e.message);
      emit(state.copyWith(status: UserBlogStatus.error, error: e.message));
    }
  }

  void postBlog(Blog blog) async {
    emit(state.copyWith(status: UserBlogStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repo.postBlog(blog);
      emit(
        state.copyWith(status: UserBlogStatus.loaded),
      );
    } on DioError catch (e) {
      print(e.message);
      emit(state.copyWith(status: UserBlogStatus.error, error: e.message));
    }
  }

  void editBlog(Blog blog) async {
    emit(state.copyWith(status: UserBlogStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repo.updateBlog(blog);
      emit(
        state.copyWith(status: UserBlogStatus.loaded),
      );
    } on DioError catch (e) {
      print(e.message);
      emit(state.copyWith(status: UserBlogStatus.error, error: e.message));
    }
  }

  void deleteBlog(Blog blog) async {
    emit(state.copyWith(status: UserBlogStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repo.deleteABlog(blog);
      emit(
        state.copyWith(status: UserBlogStatus.loaded),
      );
    } on DioError catch (e) {
      print(e.message);
      emit(state.copyWith(status: UserBlogStatus.error, error: e.message));
    }
  }
}
