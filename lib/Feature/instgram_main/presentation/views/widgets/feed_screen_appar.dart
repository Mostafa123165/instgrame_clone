import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/chates_view.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/icon_broken.dart';
import 'package:page_transition/page_transition.dart';

PreferredSizeWidget feedScreenAppar(context) => AppBar(
  backgroundColor: AppColors.appBarColor,
  leading: IconButton(
    icon: Icon(IconBroken.Camera, size: 24.w),
    onPressed: () {},
  ),
  title: SvgPicture.asset(
    'assets/images/Instagram Logo.svg',
    height: 28.h,
    width: 105.w,
  ),
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(IconBroken.Message, size: 24.w),
      onPressed: () {
        Components().navigatorAndPush(context: context, widget: const ChatScreen(),pageTransitionType: PageTransitionType.rightToLeft,duration: AppConstants.duration) ;
      },
    ),
  ],
) ;