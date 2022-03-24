import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kego_test/cubit/userblog_cubit.dart';
import 'package:kego_test/screens/add_blog_page.dart';
import 'package:kego_test/screens/edit_blog.dart';
import 'package:kego_test/services/models/user_model.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('${user.name}\'s Blogs'),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddBlogPage(userId: user.id),
                  ),
                );
              },
              icon: const Icon(Icons.add_box)),
        ],
      ),
      body: BlocProvider(
        create: (context) => UserBlogCubit()..getUserBlog(user.id),
        child: BlocBuilder<UserBlogCubit, UserBlogState>(
          builder: (context, state) {
            if (state.status == UserBlogStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return ListView.separated(
              itemBuilder: ((context, index) => Stack(
                    children: [
                      ListTile(
                        title: Text(state.blogs[index].title),
                        subtitle: Text(state.blogs[index].body),
                      ),
                      Positioned(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: (() => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EditBlogPage(
                                          blog: state.blogs[index]),
                                    ),
                                  )),
                              icon: const Icon(
                                Icons.edit_note,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<UserBlogCubit>()
                                    .deleteBlog(state.blogs[index]);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        right: 2,
                      )
                    ],
                  )),
              itemCount: state.blogs.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1.0,
                color: Colors.orange,
              ),
            );
          },
        ),
      ),
    );
  }
}
