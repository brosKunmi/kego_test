import 'package:kego_test/services/models/blog_model.dart';
import 'package:kego_test/services/models/user_model.dart';
import 'package:kego_test/services/service/blog_services.dart';
import 'package:kego_test/services/service/user_service.dart';

class UserBlogRepo {
  UserBlogRepo._();

  factory UserBlogRepo() => UserBlogRepo._();

  Future<List<Users>?> getAllUsers() async => await UserService().getUsers();

  Future<List<Blog>?> getAllBlogs() async => await BlogService().getBlogs();

  Future deleteABlog(Blog blog) async => await BlogService().deleteBlog(blog);

  Future updateBlog(Blog blog) async => await BlogService().updateBlog(blog);

  Future postBlog(Blog blog) async => await BlogService().addBlog(blog);
}
