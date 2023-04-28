import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_state.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/profile_body_widget.dart';
import 'package:instgrameclone/core/data_app/user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key ,required this.uId ,required this.fromMyProfile}) : super(key: key);
    String? uId ;
    bool fromMyProfile;
  @override
  Widget build(BuildContext context) {
    Size size = WidgetsBinding.instance.window.physicalSize;
    double ratio = WidgetsBinding.instance.window.devicePixelRatio;
    double heightScreenWithPixel = size.height / ratio;
    uId = fromMyProfile ? UserResult.data!.token : uId ;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        ProfileCubit.get(context).listenController(heightScreenWithPixel:heightScreenWithPixel );
        return  Scaffold(
         body:  ProfileBodyWidget(uId: uId!),
        );
      },
    );
  }
}
