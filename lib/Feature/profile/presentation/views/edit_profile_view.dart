import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_state.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/edit_profile_body_widget.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:instgrameclone/core/widgets/toast_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if(state is UpdateEditProfileDateSuccessState) {
          afterUpdateUserData(context) ;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: editProfileApparWidget(context, state),
          body: const SingleChildScrollView(child: EditProfileWidget()),
        );
      },
    );
  }

  Future afterUpdateUserData(context) async{
    showToastWidget(toastState: ToastStates.SUCCESS , message: "The data has been update successfully",context: context);
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pop() ;
    });
  }

}

PreferredSizeWidget editProfileApparWidget(context,ProfileState state ) =>
    AppBar(
      title: Text(
          AppStrings.editProfile
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () async{
           await ProfileCubit.get(context).updateUserData();
          },
          child: Text(AppStrings.done, style: Styles.textStyle16.copyWith(color: AppColors.blueColor)),),
      ],
      leadingWidth: 80.w,
      leading: TextButton(
        onPressed: () {
          ProfileCubit.get(context).profileImage = null ;
          Navigator.of(context).pop();
        },
        child: Text(AppStrings.cancel,
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w400)),),
    );




