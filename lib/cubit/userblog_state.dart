part of 'userblog_cubit.dart';

enum UserBlogStatus { initial, loading, loaded, error }

class UserBlogState extends Equatable {
  UserBlogState({
    this.status = UserBlogStatus.initial,
    List<Users>? users,
    List<Blog>? blogs,
    String? error,
  })  : users = users ?? [],
        blogs = blogs ?? [],
        error = error ?? '';

  final UserBlogStatus status;
  final List<Users> users;
  final List<Blog> blogs;
  final String error;

  @override
  List<Object> get props => [status, users, blogs, error];

  UserBlogState copyWith({
    UserBlogStatus? status,
    List<Users>? users,
    List<Blog>? blogs,
    String? error,
  }) {
    return UserBlogState(
      blogs: blogs ?? this.blogs,
      status: status ?? this.status,
      error: error ?? this.error,
      users: users ?? this.users,
    );
  }
}
