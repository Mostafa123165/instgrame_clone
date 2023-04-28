import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/strings.dart';

class ProfileApparWidget extends StatelessWidget {
  const ProfileApparWidget({Key? key,required this.snap,required this.uId}) : super(key: key);
  final String uId ;
  final snap;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(
        snap['name'],
        style: Styles.textStyle22,
      ),
      centerTitle: uId != UserResult.data!.token,
      actions: [
        uId == UserResult.data!.token ? TextButton(
            onPressed: (){
              HomeCubit.get(context).changeBottomNav(0);
              ProfileCubit.get(context).signOut(context);
            },
            child: Text(
              AppStrings.signOut,
              style: Styles.textStyle16.copyWith(color: AppColors.blueColor),
            )) : const SizedBox() ,
      ],
      leadingWidth:  uId == UserResult.data!.token ? 0 : 40.w,
      leading:  uId == UserResult.data!.token ? const InkWell() :
      IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)) ,
    );
  }
}
