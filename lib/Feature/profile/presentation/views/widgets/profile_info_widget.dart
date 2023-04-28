import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_cubit.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/widgets/like_animation.dart';
import 'package:instgrameclone/Feature/chats/presentation/controller/chat_cubit.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/message_view.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/edit_profile_view.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/colors.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:page_transition/page_transition.dart';
import '';
class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({Key? key , required this.snap , required this.uId}) : super(key: key);
  final snap ;
  final String uId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 38.r,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(snap['image']),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    (snap['posts'].length/2).toInt().toString(),
                    style: Styles.textStyle16,
                  ),
                  Text(
                    'Posts',
                    style: Styles.textStyle14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    snap['followers'].length.toString(),
                    style: Styles.textStyle16,
                  ),
                  Text(
                    'Followers',
                    style: Styles.textStyle14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    snap['following'].length.toString(),
                    style: Styles.textStyle16,
                  ),
                  Text(
                    'Following',
                    style: Styles.textStyle14,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h,),
        Text(
          snap['name'],
          style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          snap['bio'],
          style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15.h,),
        uId == UserResult.data!.token ?  Container(
          height: 30.h,
          width: double.infinity,
          color: Colors.grey.shade900,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.black12)
            ),
            onPressed: () {
                Components().navigatorAndPush(context: context, widget: const EditProfileView(),pageTransitionType: PageTransitionType.bottomToTop,duration: 180);
              },
            child: Text(
            AppStrings.editProfile,
            textAlign: TextAlign.center,
            style: Styles.textStyle14.copyWith(color: Colors.white),
          ),
          ),
        ) :
        Row(
          children: [
            Expanded(
              child:  LikeAnimation(
                  smaleLike: true,
                  isAnimating: snap['followers'].contains(UserResult.data!.token),
                  onEnd: null,
                  child: Container(
                    height: 30.h,
                    decoration: decorationBottom(snap),
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.black12)
                      ),
                      onPressed: () {
                        ChatCubit.get(context).addOrRemoveFollow(followers: snap['followers'], ownerUser: snap['uID']);
                      },
                      child: Text(
                        snap != null && snap['followers'].contains(UserResult.data!.token) ? AppStrings.following : AppStrings.follow,
                        textAlign: TextAlign.center,
                        style: Styles.textStyle14.copyWith(color: Colors.white),
                      ),
                    ),
                  )),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Container(
                height: 30.h,
                decoration: decorationBottom(snap,fromMessage: true),
                child: TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.black12)
                  ),
                  onPressed: () {
                   Components().navigatorAndPush(context: context, widget: MessageScreen(receiverId: snap['uID'] , receiverImage:snap['image'] , receiverName: snap['name'],), pageTransitionType: PageTransitionType.bottomToTop,duration: AppConstants.duration);
                  },
                  child: Text(
                    AppStrings.message,
                    textAlign: TextAlign.center,
                    style: Styles.textStyle14.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

BoxDecoration decorationBottom(var snap,{bool fromMessage = false }) => BoxDecoration(
color: fromMessage || snap['followers'].contains(UserResult.data!.token)?  Colors.grey.shade900 : AppColors.blueColor,
borderRadius: BorderRadius.circular(7.r)
);
