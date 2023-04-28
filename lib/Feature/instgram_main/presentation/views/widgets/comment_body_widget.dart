import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/comment_card_widget.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/widgets/circle_avatare_widget.dart';

class CommentBodyWidget extends StatelessWidget {
  const CommentBodyWidget({Key? key ,required this.postId}) : super(key: key);
  final String postId ;
  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').orderBy('dataPublished').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: SizedBox(width: 20.w,height: 20.h,child: CircularProgressIndicator(strokeWidth: 3.r,)));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  index = snapshot.data!.docs.length - index - 1 ;
                  return CommentCardWidget(snap: snapshot.data!.docs[index].data(),postId: postId,commentId: snapshot.data!.docs[index].id);
                },
                itemCount: snapshot.data!.docs.length,
              ),
            ),
            addCommentWidget(context: context,commentController: commentController,postId: postId) ,
          ],
        );
      },
    );
  }
}

Widget addCommentWidget( {required context, var commentController, required String postId}) =>
    SafeArea(
      child: Container(
        height: 60.h,
        padding:  EdgeInsets.only(left: 16.w, right: 8.w),
        child: Row(
          children: [
            InkWell(
              child: CircleAvatarWidget(radius: 16.r ,snap: null , imageUrl:UserResult.data!.image , foundSnap: false),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: TextFormField(
                controller: FeedCubit.get(context).commentController,
                decoration: InputDecoration(
                    hintText: 'Comments as ${UserResult.data!.name}',
                    border: InputBorder.none),
              ),
            ),
            TextButton(
              onPressed: () {
                FeedCubit.get(context).addComments(postId: postId);
              },
              child: Text(
                'Post',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );