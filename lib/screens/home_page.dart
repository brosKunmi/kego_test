import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kego_test/cubit/userblog_cubit.dart';
import 'package:kego_test/screens/blog_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Users List'),
      ),
      body: BlocProvider<UserBlogCubit>(
        create: (context) => UserBlogCubit()..getAllUsers(),
        child: BlocBuilder<UserBlogCubit, UserBlogState>(
          builder: (context, state) {
            if (state.status == UserBlogStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemBuilder: ((context, index) => Stack(
                    children: [
                      ListTile(
                        title: Text(state.users[index].name),
                        subtitle: Text(
                            '${state.users[index].email} \n\n${state.users[index].phone}'),
                        trailing: Text(state.users[index].id.toString()),
                        isThreeLine: true,
                      ),
                      Positioned(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    BlogPage(user: state.users[index]),
                              ),
                            );
                          },
                          child: const Text('Check Blogs'),
                        ),
                        right: 2,
                        bottom: 0,
                      )
                    ],
                  )),
              itemCount: state.users.length,
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
