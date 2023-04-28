import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/chats/presentation/controller/chat_cubit.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/receiver_message_widget.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/sender_message_widget.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/icon_broken.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';

class MessageScreenBody extends StatelessWidget {
   MessageScreenBody({Key? key , required this.receiverId , required this.receiverImage , required this.receiverName }) : super(key: key);
  final String receiverId ;
  final String receiverName ;
  final String receiverImage ;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController() ;
    return  StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).collection('chats').doc(receiverId).collection('messages').orderBy('dataTime').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicatorWidget(width: 20.w, height: 20.r , strokeWidth: 1.5.r,);
        }
        return Padding(
          padding:  EdgeInsets.all(20.r),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 10.h),
                  child: ListView.separated(
                    itemBuilder: (context , index ) {
                            if(UserResult.data!.token != snapshot.data!.docs[index].data()['senderId']) {
                              return senderMessageWidget(snapshot.data!.docs[index].data()['text']) ;
                            }
                            return receiveMessageWidget(snapshot.data!.docs[index].data()['text']) ;
                    },
                    separatorBuilder: (context,  index )=>const SizedBox(height: 20,),
                    itemCount: snapshot.data!.docs.length,
                  ),
                ),
              ),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1.0.w,
                    )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          controller: messageController,
                          onTap: (){

                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none ,
                            hintText: "type your message...",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: AppColors.blueColor,
                      child: MaterialButton(
                        onPressed: (){
                          if(messageController.text.isNotEmpty) {
                            ChatCubit.get(context).sendMessage(receiverId:receiverId ,message: messageController.text , receiverImage: receiverImage ,receiverName:receiverName );
                            messageController = TextEditingController();
                          }
                        },
                        child: const Icon(
                          IconBroken.Send,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}


