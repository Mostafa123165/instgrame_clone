import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_state.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/widgets/like_animation.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/comment_view.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/profile_view.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {Key? key,
      required this.post,
      required this.idPost,
      required this.showFollow ,
      this.fromProfilePost = false,
      required this.snapUser})
      : super(key: key);
  final post;
  final snapUser;
  final String idPost;
  final bool showFollow ;
  final bool fromProfilePost;

  @override
  Widget build(BuildContext context) {
    PageController imageController = PageController();
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AddPostCubit.get(context);
        return Card(
          child: Container(
         //   height: 500.h,
            color: AppColors.darkBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 54.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap :(){
                          Components().navigatorAndPush(context: context, widget: ProfileScreen(uId: post['ownerUid'],fromMyProfile: false),pageTransitionType: PageTransitionType.rightToLeft,duration: 200);
                        },
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(post['image']),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap :(){
                          Components().navigatorAndPush(context: context, widget: ProfileScreen(uId: post['ownerUid'],fromMyProfile: false),pageTransitionType: PageTransitionType.rightToLeft,duration: 200);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                post['ownerName'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.textStyle14.copyWith(fontSize: 13.sp),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                'Mansoura',
                                maxLines: 1,
                                style:
                                    Styles.textStyle14.copyWith(fontSize: 13.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      post['ownerUid'] == UserResult.data!.token || !showFollow ? const SizedBox() : LikeAnimation (
                              smaleLike: true,
                              isAnimating:  cubit.idPost == idPost && snapUser != null && post != null && snapUser['following'].contains(post['ownerUid']),
                              onEnd: null,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Container(
                                  width: 80.w,
                                  height: 27.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 0.7.h),
                                      borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        cubit.addOrRemoveFollow(following: snapUser['following'], ownerPostId: post['ownerUid'],postId: idPost);
                                      },
                                      child: Text(
                                        snapUser != null && snapUser['following'].contains(post['ownerUid']) ? AppStrings.following : AppStrings.follow,
                                        style: Styles.textStyle14.copyWith(color: AppColors.blueColor),
                                      )),
                                ),
                              )),
                    ],
                  ),
                ),
                InkWell(
                  onDoubleTap: () async {
                    cubit.changeIsLikeAnimating(state: true, idPost: idPost);
                    await AddPostCubit.get(context).likePost(
                      postId: idPost,
                      likes: post['likes'],
                      userUid: UserResult.data!.token,
                      fromOnTapDouble: true,
                    );
                  },
                  child: SizedBox(
                    height: 375.h,
                    child: Stack(
                      children: [
                        PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: post!['images'].length,
                          controller: imageController,
                          itemBuilder: (context, index2) => Stack(
                            children: [
                              CachedNetworkImage(
                                width: double.infinity,
                                height: 375.h,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                imageUrl: post!['images'][index2],
                                placeholder: (context, _) => Shimmer.fromColors(
                                  baseColor: AppColors.baseColorShimmer,
                                  highlightColor: AppColors.highColorShimmer,
                                  child: Container(
                                    width: 70.w,
                                    height: 105.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.circular(8.0.w),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 14.h),
                                child: Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Container(
                                    height: 26.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff121212),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${(index2 + 1).toString()}/${post!['images'].length}',
                                        textAlign: TextAlign.center,
                                        style: Styles.textStyle12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: AnimatedOpacity(
                            opacity:
                                cubit.idPost == idPost && cubit.isLikeAnimating
                                    ? 1
                                    : 0,
                            duration: const Duration(milliseconds: 150),
                            child: LikeAnimation(
                              isAnimating: cubit.isLikeAnimating,
                              duration: const Duration(
                                milliseconds: 400,
                              ),
                              smaleLike: false,
                              onEnd: () {
                                AddPostCubit.get(context).changeIsLikeAnimating(
                                    state: false, idPost: idPost);
                              },
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 100.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Padding(
                  padding: AppConstants.defaultPadding2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LikeAnimation(
                        isAnimating:
                            post['likes'].contains(UserResult.data!.token),
                        smaleLike: true,
                        onEnd: null,
                        child: IconButton(
                          onPressed: () async {
                            await AddPostCubit.get(context).likePost(
                              postId: idPost,
                              likes: post['likes'],
                              userUid: UserResult.data!.token,
                            );
                          },
                          icon: post['likes'].contains(UserResult.data!.token)
                              ? SvgPicture.asset(
                                  AppConstants.svgLikeFull,
                                  color: Colors.red,
                                )
                              : SvgPicture.asset(AppConstants.svgLike),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Components().navigatorAndPush(
                              context: context,
                              widget: CommentScreen(postId: idPost),
                              pageTransitionType:
                                  PageTransitionType.rightToLeft,
                              duration: 150);
                        },
                        icon: SvgPicture.asset(AppConstants.svgComment),
                      ),
                      const Spacer(),
                      SmoothPageIndicator(
                        controller: imageController,
                        count: post!['images'].length,
                        effect: ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: AppColors.blueColor,
                            expansionFactor: 1.1.w,
                            dotHeight: 6.h,
                            dotWidth: 6.w,
                            spacing: 4.w),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: AppConstants.defaultPadding2,
                  child: Text(
                    'Liked by ${post['likes'].length.toString()} others',
                    style: Styles.textStyle14,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
