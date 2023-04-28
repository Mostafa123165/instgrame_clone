import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileCubit.get(context).getEditProfilesDate();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context) ;
        return Column(
          children: [
            state is UpdateEditProfileDateLoadingState ?  const LinearProgressIndicator() : const SizedBox(),
            SizedBox(
              height: 18.h,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(47.5.r),
              child: CachedNetworkImage(
                height: 95.r,
                width: 95.r,
                fit: BoxFit.cover,
                imageUrl: ProfileCubit.get(context).profileImage ?? UserResult.data!.image ,
                placeholder: (context, _) => Shimmer.fromColors(
                  baseColor: AppColors.baseColorShimmer,
                  highlightColor: AppColors.highColorShimmer,
                  child: Container(
                    width: 70.w,
                    height: 105.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0.w),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  ProfileCubit.get(context).pickImageFromDevice(fromEditProfile: true);
                },
                child: Text(
                  AppStrings.changeProfilePhone,
                  style:
                      Styles.textStyle14.copyWith(color: AppColors.blueColor),
                )),
            SizedBox(
              height: 13.h,
            ),
            editProfileItem(text: AppStrings.name, controller: cubit.nameController),
            editProfileItem(text: AppStrings.bio, controller: cubit.bioController),
            editProfileItem(text: AppStrings.email, controller: cubit.emailController),
            editProfileItem(text: AppStrings.phone, controller: cubit.phoneController),
          ],
        );
      },
    );
  }
}

Widget editProfileItem({required String text, required TextEditingController controller}) =>
    SizedBox(
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: SizedBox(
              width: 45.w,
              child: Text(
                text,
                style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  width: 0.29.h,
                  color: Colors.grey,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  width: 0.29.h,
                  color: AppColors.blueColor,
                )), //
              ),
              controller: controller,
            ),
          )
        ],
      ),
    );
