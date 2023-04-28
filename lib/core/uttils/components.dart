import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/login/login_cubit.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/login_screen.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/icon_broken.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:page_transition/page_transition.dart';

class Components {
  void showToast({
    required String message,
    required ToastStates toastState,
    required context,
    int seconds = 2,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          backgroundColor: choseColorToast(toastState),
          width: MediaQuery.of(context).size.width / 1.5,
          duration: Duration(seconds: seconds),
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
        ),
      );

  Color choseColorToast(ToastStates state) {
    Color? color;

    switch (state) {
      case ToastStates.ERROR:
        color = Colors.red;
        break;

      case ToastStates.SUCCESS:
        color = AppColors.blueColor;
        break;

      case ToastStates.WARNING:
        color = Colors.amberAccent;
        break;
    }

    return color;
  }

  Widget defaultButton ({required context , required String text , required Color borderColor, required Color backGroundColor , required Color textBackGroundColor, required VoidCallback onPressed , double valueNewWidth = 150}) => Container(
    height: 37.h,
    width: valueNewWidth,
    decoration: BoxDecoration(
      color:backGroundColor,
      border: Border.all(color: borderColor), // Theme.of(context).primaryColor
      borderRadius:  BorderRadius.all(
          Radius.circular(
            10.0.r,
          )
      ),
    ),
    child: TextButton(
        onPressed: onPressed ,
        child: Text(
          text,
          style:GoogleFonts.tajawal(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
        )),
  );


  Widget defaultTextFormField({
  required TextEditingController controller,
  required String hint,
  required TextStyle style,
  required IconData icon,
  VoidCallback? onPressed,
  IconData? iconSuffix ,
  bool password = false ,
}) => TextFormField(
        style: style,
        controller: controller,
        obscureText: password,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
            suffixIcon:IconButton(
              onPressed: onPressed ,
              icon:  Icon(iconSuffix),
            ),
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w)),
      );

  void navigatorAndPush({required BuildContext context, required widget , PageTransitionType pageTransitionType = PageTransitionType.fade , int duration = 600 }) {
    Navigator.push(context, PageTransition(child: widget,type: pageTransitionType ,duration:  Duration(milliseconds: duration)));
  }

}

enum ToastStates { ERROR, SUCCESS, WARNING }

Color choseColorToast(ToastStates state) {
  Color? color;

  switch (state) {
    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.SUCCESS:
      color = AppColors.blueColor;
      break;

    case ToastStates.WARNING:
      color = Colors.amberAccent;
      break;
  }

  return color;




}
