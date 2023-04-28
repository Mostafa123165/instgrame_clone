import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/core/uttils/colors.dart';

ThemeData lightTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: AppColors.darkBackgroundColor ,

  appBarTheme:  AppBarTheme(
    color: AppColors.darkBackgroundColor ,
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color:Colors.white ,
      fontSize:16.sp,
    ),

    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.darkBackgroundColor,
      statusBarIconBrightness: Brightness.light,
    ),
  ),


);