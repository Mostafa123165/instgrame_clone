import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/comment_body_widget.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/strings.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key, required this.postId}) : super(key: key);
  final String postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.comments,
          style: Styles.textStyle22,
        ),
      ),
      body:  CommentBodyWidget(postId: postId),
    );
  }
}

