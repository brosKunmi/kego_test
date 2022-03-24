import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kego_test/cubit/userblog_cubit.dart';
import 'package:kego_test/services/models/blog_model.dart';

import '../widgets/text_forms.dart';

final _formKey = GlobalKey<FormState>();

class EditBlogPage extends StatelessWidget {
  const EditBlogPage({Key? key, required this.blog}) : super(key: key);

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    String _title = '';
    String _body = '';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Edit blog post'),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (context) => UserBlogCubit(),
        child: BlocConsumer<UserBlogCubit, UserBlogState>(
          listener: (context, state) {
            if (state.status == UserBlogStatus.loaded) {
              _formKey.currentState!.reset();
              var _snackBar =
                  const SnackBar(content: Text('Blog updated successflly'));
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            }
            if (state.status == UserBlogStatus.error) {
              var _snackBar = SnackBar(content: Text(state.error));
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextForms(
                    onSubmitted: (s) {
                      _title = s!;
                    },
                    maxLines: 2,
                    hint: 'Title',
                    initial: blog.title,
                  ),
                  TextForms(
                    onSubmitted: (s) {
                      _body = s!;
                    },
                    hint: 'Body',
                    maxLines: 8,
                    initial: blog.body,
                  ),
                  const SizedBox(height: 20),
                  state.status == UserBlogStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            context.read<UserBlogCubit>().editBlog(
                                  Blog(
                                      userId: blog.userId,
                                      title: _title,
                                      id: blog.id,
                                      body: _body),
                                );
                          },
                          child: const Text('Edit Blog'),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
