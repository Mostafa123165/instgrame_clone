import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/widgets/circle_avatare_widget.dart';

PreferredSizeWidget messageScreenAppar ({required String name , required String image}) => AppBar(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatarWidget(snap: null, radius: 15.r,foundSnap: false,imageUrl: image,),
      SizedBox(width: 15.w,),
      Text(
        name ,
        style: Styles.textStyle22,
      ),

    ],
  ),
  centerTitle: true ,
  leadingWidth: 50.w,
  actions: [
    SizedBox(
      width: 50.w,
    ),
  ],
);