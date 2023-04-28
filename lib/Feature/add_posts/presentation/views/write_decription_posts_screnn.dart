import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_state.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_cubit.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/views/home_screen.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';

class WriteDescriptionPost extends StatelessWidget {
  const WriteDescriptionPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if(state is AddPostSuccessState) {
          AddPostCubit.get(context).clear() ;
          Navigator.of(context).pop() ;
        }
      },
      builder: (context, state) {
        var cubit = AddPostCubit.get(context) ;
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  child: Text(
                      AppStrings.post, style: Styles.textStyle16.copyWith(
                      color: AppColors.blueColor)),
                  onPressed: () {
                    cubit.uploadPost(description: postController.text);
                  }
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: AppConstants.defaultPaddingAll20,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage:  NetworkImage(
                              UserResult.data!.image),
                        ),
                        SizedBox(width: 10.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                'Mostafa Tarek',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.textStyle14.copyWith(fontSize: 13.sp),
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                'Mansoura',
                                maxLines: 1,
                                style: Styles.textStyle14.copyWith(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'What is your mind , Mostafa Tarek ',
                        hintStyle: Styles.textStyle14,
                        border: InputBorder.none,
                      ),
                      controller: postController,
                    ) ,
                  ],
                ),
              ),
              if(state is AddPostLoadingState)Center(
                child: CircularProgressIndicatorWidget(
                  height: 25.h,
                  width: 25.w,
                  strokeWidth: 2.5.r,
                )
              ),
            ],
          ),
        );
      },
    );
  }
}
