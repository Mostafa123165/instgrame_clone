import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/post_widget.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';

class InfoProfilePostWidget extends StatelessWidget {
  const InfoProfilePostWidget({Key? key , required this.postId , required this.showFollow}) : super(key: key);
  final String postId ;
  final bool showFollow ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(postId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return  CircularProgressIndicatorWidget(height: 15.r , width: 15.r,);
          }
          return PostWidget(post: snapshot.data, idPost:postId,snapUser: null ,fromProfilePost: true,showFollow: showFollow,);
        }
      ),
    );
  }
}
