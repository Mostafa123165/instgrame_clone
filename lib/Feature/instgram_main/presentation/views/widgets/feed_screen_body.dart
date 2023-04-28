import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/post_widget.dart';
import 'package:instgrameclone/core/data_app/user.dart';

class FeedScreenBody extends StatelessWidget {
  const FeedScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return StreamBuilder(
       stream: FirebaseFirestore.instance.collection('posts').orderBy('dataTime').snapshots(),
       builder: (context , AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         return  StreamBuilder(
           stream: FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).snapshots(),
           builder: (context, snapUser) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(
                 child: CircularProgressIndicator(),
               );
             }
             return CustomScrollView(
               slivers: [
                 SliverList(
                   delegate: SliverChildBuilderDelegate(
                         (BuildContext context, int index) {
                         int revIndex =  snapshot.data!.docs.length - index - 1;
                       String postId =  snapshot.data!.docs[revIndex].id;
                       return  PostWidget(post: snapshot.data!.docs[revIndex].data(),idPost:postId,snapUser:snapUser.data,showFollow: true,) ;
                     },
                     childCount: snapshot.data!.docs.length,
                   ),
                 ),
               ],
             );
           }
         );
       },
     );

  }
}
