import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/Register/register_cubit.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/widgets/register_body_widget.dart';
import 'package:instgrameclone/core/uttils/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left , size: 35.w),
            onPressed: (){
              Navigator.of(context).pop() ;
            },
          ),
        ),
        body: const Center(
            child: SingleChildScrollView(child: RegisterBodyWidget())),
      ),
    );
  }
}

