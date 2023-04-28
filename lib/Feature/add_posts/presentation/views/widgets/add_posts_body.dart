import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_state.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';

class AppPostsBody extends StatefulWidget {
  const AppPostsBody({Key? key}) : super(key: key);

  @override
  State<AppPostsBody> createState() => _AppPostsBodyState();
}

class _AppPostsBodyState extends State<AppPostsBody> {


  ScrollController scrollController = ScrollController() ;
  @override
  void initState() {
     AddPostCubit.get(context).getAllImageInGallery() ;
     scrollController.addListener(() async{
       if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
         AddPostCubit.get(context).loadMoreAsset() ;
       }
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = AddPostCubit.get(context) ;
        return ConditionalBuilder(
          condition: AddPostCubit.get(context).imagesInAssets.isNotEmpty,
          builder: (context) =>  CustomScrollView (
            controller: scrollController ,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  height: 250.h,
                    width: double.infinity,
                    child: Image.file(
                    fit: BoxFit.cover,
                    height: 250.h,
                    width: double.infinity,
                    File(
                        AddPostCubit.get(context).choiceImages.isEmpty ? AddPostCubit.get(context).imagesInAssets[0].file : AddPostCubit.get(context).choiceImages[ AddPostCubit.get(context).choiceImages.length - 1 ].file,
                    ),
                  )
                ),
              ),
              if(cubit.imagesInAssets.isNotEmpty)
               SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return GestureDetector(
                        onTap: () => cubit.onTap(index: index,context: context),
                        onLongPress: () => cubit.onLongPress(index: index,context: context) ,
                        child: SizedBox(
                          width: 93.w,
                          height: 40.h,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image.file(
                                fit: BoxFit.cover,
                                File(AddPostCubit.get(context).imagesInAssets[index].file),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              if(AddPostCubit.get(context).imagesInAssets[index].choice) Container(
                                color: Colors.white54,
                              ) ,
                              if(AddPostCubit.get(context).imagesInAssets[index].choice && AddPostCubit.get(context).longPress ) CircleAvatar(
                                radius: 10.r,
                                backgroundColor: AppColors.blueColor,
                                child: Align( alignment: AlignmentDirectional.center , child: Text((AddPostCubit.get(context).imagesInAssets[index].indexInListChoice+1).toString(),style:Styles.textStyle14.copyWith(color: Colors.white),)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: AddPostCubit.get(context).imagesInAssets.length,
                  ),
                ),
            ],
          ),
          fallback: (context) => const SizedBox(),
        );
      },
    );
  }
}
