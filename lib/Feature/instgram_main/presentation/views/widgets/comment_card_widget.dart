import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/widgets/like_animation.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/profile_view.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/widgets/circle_avatare_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget({Key? key ,required this.snap ,required this.commentId , required this.postId}) : super(key: key);
  final Map<String , dynamic >snap ;
  final String commentId ;
  final String postId;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Components().navigatorAndPush(context: context, widget: ProfileScreen(uId: snap['uId'],fromMyProfile: false),pageTransitionType: PageTransitionType.rightToLeft,duration: 200);
            },
            child: CircleAvatarWidget(snap: snap , radius: 23.r),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap : (){
                    Components().navigatorAndPush(context: context, widget: ProfileScreen(uId: snap['uId'],fromMyProfile: false),pageTransitionType: PageTransitionType.rightToLeft,duration: 200);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${snap['name']}   ${FeedCubit.get(context).timeAddPost(endDate: DateTime.now(), startDate: snap['dataPublished'])}\n',
                          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: snap['text'],
                          style: Styles.textStyle14.copyWith(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              LikeAnimation(
                  smaleLike: true,
                  isAnimating:  snap['likes'].contains(UserResult.data!.token),
                  onEnd: null,
                  child: InkWell(
                    onTap: (){
                      FeedCubit.get(context).addLikeToComment(
                          postId: postId,
                          commentId: commentId,
                          userId:  UserResult.data!.token,
                          likes: snap['likes'],
                      );
                    },
                    child: Container(
                      padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 8.w),
                      child: snap['likes'].contains(UserResult.data!.token) ? SvgPicture.asset(AppConstants.svgLikeFull,color: Colors.red,width: 15.w,height: 15.h,) :SvgPicture.asset(AppConstants.svgLike,width: 15.w,height: 15.h) ,

                  ),
                  )
              ),
              Text(
                snap['likes'].length.toString(),
                style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10 .sp),
              )
            ],
          )
        ],
      ),
    );
  }
}

