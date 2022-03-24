import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kego_test/cubit/userblog_cubit.dart';
import 'package:kego_test/services/models/blog_model.dart';
import 'package:kego_test/widgets/text_forms.dart';

final _formKey = GlobalKey<FormState>();

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    String _title = '';
    String _body = '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Submit a blog post'),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (context) => UserBlogCubit(),
        child: BlocConsumer<UserBlogCubit, UserBlogState>(
          listener: (context, state) {
            if (state.status == UserBlogStatus.loaded) {
              _formKey.currentState!.reset();
              var _snackBar =
                  const SnackBar(content: Text('Blog submitted successflly'));
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
                  ),
                  TextForms(
                    onSubmitted: (s) {
                      _body = s!;
                    },
                    hint: 'Body',
                    maxLines: 8,
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
                            context.read<UserBlogCubit>().postBlog(
                                  Blog(
                                      userId: userId,
                                      title: _title,
                                      body: _body),
                                );
                          },
                          child: const Text('Submit'),
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
