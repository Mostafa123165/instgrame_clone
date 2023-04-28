
import 'dart:convert';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/instgram_main/data/models/comments_model.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FeedCubit extends Cubit<FeedState> {
  FeedCubit() : super(FeedInitial());

  static FeedCubit get(context) => BlocProvider.of(context) ;
  FirebaseFirestore fireStore = FirebaseFirestore.instance ;
  int currentIndexInBottomNav = 0 ;

  List<BottomNavigationBarItem> navList = [
    const BottomNavigationBarItem(icon: Icon( Icons.home_rounded),label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.search,),label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined,),label: ''),
    BottomNavigationBarItem(icon:CircleAvatar(radius: 10.r,),label: ''),
  ] ;

  IconData getIconBottomNav({required int index}) {
    if(currentIndexInBottomNav == 0) {
      return Icons.home_filled;
    }
    return Icons.home_filled ;
  }

  void changeIndexInBottomNave({required int index}) {
    currentIndexInBottomNav = index ;
    emit(ChangeIndexBottomNavState());
  }

  TextEditingController commentController = TextEditingController();

  void addComments({required String postId}) {

    try {
      FirebaseFirestore.instance.collection('posts').doc(postId)
          .collection('comments')
          .doc()
          .set(CommentModel(
        text: commentController.text,
        likes: const [],
        image: UserResult.data!.image,
        name: UserResult.data!.name,
        uId: UserResult.data!.token,
        dataPublished: DateTime.now().millisecondsSinceEpoch,
      ).toMap());
      commentController = TextEditingController() ;
      emit(AddCubitSuccessState());
    }
    catch (e) {
      print(e.toString());
    }

  }

  Future<void> addLikeToComment({required String userId , required String commentId , required List likes , required String postId} ) async {
    try {
      if(likes.contains(userId)){
        await fireStore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes' : FieldValue.arrayRemove([userId]),}
        );
      }
      else {
        await fireStore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes' : FieldValue.arrayUnion([userId]),}
        );
      }
    }
    catch (e) {
      print(e.toString()) ;
    }
  }

  String timeAddPost({required int startDate,required DateTime endDate}) {

    int difference = endDate.millisecondsSinceEpoch - startDate ;
    int days = (difference / (1000 * 60 * 60 * 24)).floor();
    int hour = (difference / (1000 * 60 * 60 )).floor();
    int minute = (difference / (1000 * 60 )).floor();
    int sec = (difference / (1000)).floor();
    if(days == 0) {
      if(hour == 0) {
        if(minute == 0) {
          return "${sec}s" ;
        }
        return '${minute}m' ;
      }
      return "${hour}h";
    }
    return "${days}d";
  }


  void updateDeviceToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    await _firebaseMessaging.getToken().then((token){
      FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).update({
        "tokenDevice" : token ,
      });
    });
  }



}
