
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/chats/presentation/controller/chat_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:http/http.dart' as http;
import 'package:instgrameclone/core/uttils/constants.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());


  static ChatCubit get(context) => BlocProvider.of(context) ;

  FirebaseFirestore fireStore = FirebaseFirestore.instance ;

  Future<void> addOrRemoveFollow({required List followers, required String ownerUser}) async {
    if(followers.contains(UserResult.data!.token)) {
      await fireStore.collection('users').doc(ownerUser).update({
        'followers' : FieldValue.arrayRemove([UserResult.data!.token]),
      });

      await fireStore.collection('users').doc(UserResult.data!.token).update({
        'following' : FieldValue.arrayRemove([ownerUser]),
      });
    }
    else {
      await fireStore.collection('users').doc(ownerUser).update({
        'followers' : FieldValue.arrayUnion([UserResult.data!.token]),
      });
      await fireStore.collection('users').doc(UserResult.data!.token).update({
        'following' : FieldValue.arrayUnion([ownerUser]),
      });

    }
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? message ;

  void clearMessage() {
    message = null ;
    emit(ClearMessages());
  }


  Future<void> sendMessage({required String receiverId , required String message , required String receiverName , required String receiverImage} ) async{


    try {
      await FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).collection('chats').doc(receiverId).collection('messages').add({
            "dataTime" : DateTime.now().toString(),
            "receiverId" : receiverId,
            "senderId" : UserResult.data!.token,
            "text" : message ,
          });
      await FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(UserResult.data!.token).collection('messages').add({
        "dataTime" : DateTime.now().toString(),
        "receiverId" : receiverId,
        "senderId" : UserResult.data!.token,
        "text" : message ,
      });
      await FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).collection('chats').doc(receiverId).set(toMap(
        image: receiverImage,
        name: receiverName,
        message: message,
      ));
        await FirebaseFirestore.instance.collection('users').doc(receiverId).collection('chats').doc(UserResult.data!.token).set(toMap(
        image: UserResult.data!.image,
        name: UserResult.data!.name,
        message: message,
      ));

    }catch(e) {
      print(e.toString()) ;
    }
    await FirebaseFirestore.instance.collection('users').doc(receiverId).get().then((value) {
      sendFcmMessaging(title:UserResult.data!.name , body: message, token: value.data()!['tokenDevice'],receiverId: receiverId);
    });


  }

  void sendFcmMessaging({required String token , required String body ,required String title , required String receiverId}) async{

    try {
      await http.post(
        Uri.parse(
          'https://fcm.googleapis.com/fcm/send',
        ),
        headers: <String,String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAxbkYSGU:APA91bE4YnqIz34YVc2rhZbPzq_PMp80KSJJ_XA3xdsWGD7B9ZFAawFsV9YnHI54p3PmW6YlGlzKXLDAnt4VhbpKrsP7Gw25F3OAxDw9KMZFytXbvbSxIbnuGjPbHx5cQQJZ6wLaLdR5',
        } ,
        body: jsonEncode(
          <String,dynamic> {
            'priority' : 'high' ,
            "notification":<String ,dynamic>{
              "title":title,
              "body": body,
            },
            "to" : token ,
          },
        ),
      ).then((value) {
        print(value.body) ;
      });
      print("SUCCESS") ;
    }catch (e) {
      print(e.toString());
    }

    addNotificationInFireBase(image: UserResult.data!.image, name: title ,text: body, id: receiverId, kind: 'message') ;

  }

  void addNotificationInFireBase({required String id ,required String name , required String kind , required String image , required String text}) async{
    await FirebaseFirestore.instance.collection('notifications').doc(id).collection('notify').doc().set({
      'name'  :  name ,
      'kind'  :  kind ,
      'image' : image ,
      'text'  : text ,
    });
  }

  Map<String,dynamic> toMap({required String name , required String image , required String message}) {
    return {
      "name" : name ,
      "image" : image,
      "lastMessage" : message ,
      "publishedTime" : DateTime.now().millisecondsSinceEpoch ,
    };
  }



}
