import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/Register/register_cubit.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/Register/register_state.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/icon_broken.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterBodyWidget extends StatelessWidget {
  const RegisterBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RegisterCubit();
        return Padding(
          padding: AppConstants.defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/Instagram Logo.svg',
              ),
              SizedBox(
                height: 42.h,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppStrings.descriptionRegister,
                  style: Styles.textStyle14.copyWith(fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Components().defaultTextFormField(
                  controller: nameController,
                  hint: AppStrings.name,
                  style: Styles.textStyle14,
                  icon: IconBroken.User),
              SizedBox(
                height: 15.h,
              ),
              Components().defaultTextFormField(
                  controller: emailController,
                  hint: AppStrings.email,
                  style: Styles.textStyle14,
                  icon: Icons.email_outlined),
              SizedBox(
                height: 15.h,
              ),
              Components().defaultTextFormField(
                  controller: phoneController,
                  hint: AppStrings.mobilePhone,
                  style: Styles.textStyle14,
                  icon: IconBroken.Call),
              SizedBox(
                height: 15.h,
              ),
              Components().defaultTextFormField(
                  controller: passwordController,
                  hint: AppStrings.password,
                  password: RegisterCubit.get(context).statePassword,
                  style: Styles.textStyle14,
                  icon: IconBroken.Lock,
                  iconSuffix: RegisterCubit.get(context).statePassword
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  onPressed: () {
                    RegisterCubit.get(context).changeStatePassword();
                  }),
              SizedBox(
                height: 50.h,
              ),
              RoundedLoadingButton(
                width: MediaQuery.of(context).size.width,
                color: AppColors.blueColor,
                successIcon: FontAwesomeIcons.dongSign,
                failedIcon: Icons.error,
                controller: cubit.registerController,
                borderRadius: 5.r,
                onPressed: () async {
                  await cubit.registerWithEmailAndPassword(
                    email: emailController.text,
                    phone: phoneController.text,
                    name: nameController.text,
                    password: passwordController.text,
                    context: context,
                  );
                },
                child: Text(
                  AppStrings.register,
                  style: Styles.textStyle14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
