import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/login/login_cubit.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/login/login_state.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/register_screen.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/views/home_screen.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/icon_broken.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccessState) {
          Components().showToast(message: AppStrings.successLogin , context: context , toastState: ToastStates.SUCCESS);
          Navigator.pushAndRemoveUntil(context, PageTransition(child: HomeScreen(), type: PageTransitionType.fade), (route) => false);
        }
        else if(state is LoginErrorState) {
          Components().showToast(message: state.message , context: context , toastState: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context) ;
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
              Components().defaultTextFormField(
                style: Styles.textStyle14,
                controller: emailController,
                hint: AppStrings.email ,
                icon: Icons.email_outlined
              ) ,

              SizedBox(
                height: 12.h,
              ),
              Components().defaultTextFormField(
                style: Styles.textStyle14,
                password: LoginCubit.get(context).statePassword,
                controller: passwordController,
                hint: AppStrings.password ,
                icon: IconBroken.Lock,
                iconSuffix: LoginCubit.get(context).statePassword ? Icons.visibility_off_outlined :  Icons.remove_red_eye_outlined,
                onPressed: (){
                  LoginCubit.get(context).changeStatePassword();
                }
              ) ,
              TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPassword,
                  style: Styles.textStyle14.copyWith(
                    color: AppColors.blueColor,
                  ),
                ),
              ),
              RoundedLoadingButton(
                width: MediaQuery.of(context).size.width,
                color: AppColors.blueColor,
                successIcon: FontAwesomeIcons.dongSign,
                failedIcon: Icons.error,
                controller: cubit.loginController,
                borderRadius: 5.r,
                onPressed: () async {
                  await cubit.signWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                },
                child: Text(
                  AppStrings.logIn,
                  style: Styles.textStyle14,
                ),
              ),
              SizedBox(
                height: 37.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.facebook,
                    color: AppColors.blueColor,
                  ),
                  TextButton(
                    onPressed: ()  {
                       cubit.signWithFacebook();
                    },
                    child: Text(
                      AppStrings.logWithFacebook,
                      style: Styles.textStyle14.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(AppStrings.or, style: Styles.textStyle12),
              SizedBox(
                height: 28.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.dontHaveAccount, style: Styles.textStyle14),
                  TextButton(
                    onPressed: () {
                      Components().navigatorAndPush(context: context, widget: const RegisterScreen(),pageTransitionType: PageTransitionType.rightToLeft,duration: 230);
                    },
                    child: Text(
                      AppStrings.signUp,
                      style: Styles.textStyle14.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
