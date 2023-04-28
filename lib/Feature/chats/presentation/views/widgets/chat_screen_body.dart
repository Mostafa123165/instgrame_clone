import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/chat_item_widget.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController() ;

    return  StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).collection('chats').snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicatorWidget(height: 20.h,width: 20.w,strokeWidth: 2.r,));
        }
        return ListView.builder(
          itemBuilder: (context, index) => ChatItemsWidget(snap: snapshot.data!.docs[index].data(),receiverId: snapshot.data!.docs[index].id,name:snapshot.data!.docs[0].data()['name']),
          itemCount: snapshot.data!.docs.length,
          controller: controller,
        );
      }
    );
  }
}
