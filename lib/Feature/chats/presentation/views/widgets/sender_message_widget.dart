import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget senderMessageWidget (String message) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration:  BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(10.0.r) ,
        topEnd: Radius.circular(10.0.r) ,
        topStart : Radius.circular(10.0.r) ,
      ),
    ),
    padding:  EdgeInsets.symmetric(
      vertical: 5.h,
      horizontal: 10.w ,
    ),
    child: Text(
      message,
    ),
  ),
);