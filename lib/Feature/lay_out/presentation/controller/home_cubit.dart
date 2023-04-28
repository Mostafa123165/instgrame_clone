
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/add_posts_screen.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/feed_view.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_state.dart';
import 'package:instgrameclone/Feature/notification/presentation/views/notification_view.dart';
import 'package:instgrameclone/Feature/notification/presentation/views/widgets/notitfication_body.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/profile_view.dart';
import 'package:instgrameclone/Feature/search/presentation/views/search_screen.dart';
import 'package:instgrameclone/core/data_app/user.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);


  List<Widget> bottomNavWidget = [
    const FeedScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    const NotificationScreen(),
    ProfileScreen(uId: UserResult.data!.token , fromMyProfile: true),
  ];

  List<BottomNavigationBarItem> bottomNavIcon = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 30.r),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon( Icons.search, size: 30.r),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle, size: 30.r),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite, size: 30.r),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 30.r),
      label: "",
    ),
  ];

  int indexNav = 0;
  int lastIndex = 0 ;
  void changeBottomNav(int index) {
    lastIndex = indexNav ;
    indexNav = index;
    print(indexNav.toString()) ;
    emit(ChangeBottomNaveState());
  }

}
