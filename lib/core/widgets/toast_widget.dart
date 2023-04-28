import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/components.dart';

void showToastWidget({
  required String message,
  required ToastStates toastState,
  required context ,
  int seconds = 2 ,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(message , textAlign: TextAlign.center,style: Styles.textStyle14.copyWith(color: Colors.white)),
        backgroundColor: choseColorToast(toastState),
        width: MediaQuery.of(context).size.width / 1.5,
        duration:  Duration(seconds: seconds),
        padding:  EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
      ),
    );


