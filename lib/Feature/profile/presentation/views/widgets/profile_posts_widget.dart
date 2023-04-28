import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/info_about_post_widget.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePostsWidget extends StatelessWidget {
  const  ProfilePostsWidget({Key? key , required this.snap , }) : super(key: key);
  final snap ;
  @override
  Widget build(BuildContext context) {
    print(snap['posts'].length.toString());

    if(snap['posts'].length == 0 ) {
      return notFoundPostsWidget(context) ;
    }

      return  SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate((context, i) {
          return GestureDetector (
            onTap: () async{
              String postId = snap['posts'][i*2+1]['postId'] ;
              Components().navigatorAndPush(context: context, widget: InfoProfilePostWidget(postId:postId,showFollow: false), pageTransitionType: PageTransitionType.rightToLeft,duration: 230);
            },
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:  snap['posts'][i*2]['image'],
              placeholder: (context, _) => Shimmer.fromColors(
                baseColor: AppColors.baseColorShimmer,
                highlightColor: AppColors.highColorShimmer,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error_outline),
            ),
          ) ;
        },
          childCount: (snap['posts'].length / 2).toInt() ,
        ),
      ) ;

  }

}

Widget notFoundPostsWidget(context) => SliverToBoxAdapter(
  child: Column(
    children: [
      Text(
        AppStrings.profile ,
        style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold,fontSize: 20.sp),
      ),
      SizedBox(height: 2.h,),
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 90.r,
            width: 90.r,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white
              ),
              borderRadius: BorderRadius.circular(45.r),
            ),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Center(child:  Icon(Icons.add,size: 25.r,)),
          ),
        ],
      ),
      SizedBox(height: 7.h,),
      Text(
        AppStrings.whenYouSharePhotosAndVideos ,
        style: Theme.of(context).textTheme.caption,
      ),
      SizedBox(height: 7.h,),
      Text(
        AppStrings.theyWillAppearOnYourProfile ,
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  ),
);
