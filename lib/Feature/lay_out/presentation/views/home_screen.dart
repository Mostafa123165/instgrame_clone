import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_cubit.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_state.dart';
import 'package:instgrameclone/core/uttils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.darkBackgroundColor,
            selectedItemColor: AppColors.blueColor,
            elevation: 0.0,
            items: cubit.bottomNavIcon,
            onTap: (index){
               cubit.changeBottomNav(index) ;
            },
            currentIndex: cubit.indexNav,
            type: BottomNavigationBarType.fixed,
          ),
          body: cubit.bottomNavWidget[HomeCubit.get(context).indexNav],
        );
      },
    );
  }
}
