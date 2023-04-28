
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/core/uttils/colors.dart';

Widget receiveMessageWidget(String message) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration: BoxDecoration(
      color: AppColors.blueColor,
      borderRadius:  BorderRadiusDirectional.only(
        bottomStart: Radius.circular(10.0.r) ,
        topEnd: Radius.circular(10.0.r) ,
        topStart : Radius.circular(10.0.r) ,
      ),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 5.h,
      horizontal: 10.w ,
    ),
    child: Text(
      message,
    ),
  ),
);
