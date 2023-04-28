import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_state.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/widgets/add_posts_body.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/write_decription_posts_screnn.dart';
import 'package:instgrameclone/Feature/lay_out/presentation/controller/home_cubit.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/strings.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AddPostCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 65.w,
            leading: TextButton(
              child: Text(AppStrings.cancel, style: Styles.textStyle16),
              onPressed: () {
                HomeCubit.get(context).changeBottomNav(HomeCubit.get(context).lastIndex);
                cubit.remove();
              },
            ),
            actions: [
              TextButton(
                child: Text(AppStrings.next,
                    style: Styles.textStyle16
                        .copyWith(color: AppColors.blueColor)),
                onPressed: () {
                  Components().navigatorAndPush(
                      context: context, widget: const WriteDescriptionPost());
                }
              ),
            ],
          ),
          body: const AppPostsBody(),
        );
      },
    );
  }
}
