import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/views/widgets/like_animation.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:instgrameclone/core/widgets/toast_widget.dart';
import 'package:shimmer/shimmer.dart';

class StoresWidget extends StatelessWidget {
  const StoresWidget({
    Key? key,
    required this.snap,
    required this.uid,
  }) : super(key: key);
  final snap;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is PicImageFromGallerySuccessState) {
          showToastWidget(
            context: context,
            message: AppStrings.addStorySuccessMessage,
            toastState: ToastStates.SUCCESS,
          );
        } else if (state is PicImageFromGalleryErrorState) {
          showToastWidget(
            context: context,
            message: state.message,
            toastState: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: SizedBox(
              height: 80.h,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if ((state is! PicImageFromGalleryLoadingState &&
                                  index == snap['stories'].length) ||
                              (state is PicImageFromGalleryLoadingState &&
                                  index == snap['stories'].length + 1)) {
                            return GestureDetector(
                              onTap: () async {
                                ProfileCubit.get(context)
                                    .changeBottomState(snap);
                              },
                              child: UserResult.data!.token == uid
                                  ? LikeAnimation(
                                      isAnimating: snap['bottom'],
                                      smaleLike: true,
                                      onEnd: () async {
                                        await ProfileCubit.get(context)
                                            .pickImageFromDevice();
                                      },
                                      child: CircleAvatar(
                                        radius: 28.4.r,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 28.r,
                                          child: const Icon(Icons.add),
                                        ),
                                      ))
                                  : const SizedBox(),
                            );
                          } else if (index == snap['stories'].length &&
                              state is PicImageFromGalleryLoadingState) {
                            return CircleAvatar(
                              radius: 28.r,
                              child: SizedBox(
                                  width: 15.r,
                                  height: 15.r,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 0.6.r,
                                  )),
                            );
                          }
                          return storiesImage(snap, index);
                        },
                        itemCount: state is PicImageFromGalleryLoadingState
                            ? snap['stories'].length + 2
                            : snap['stories'].length + 1,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

Widget storiesImage(var snap, int index) => Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: CachedNetworkImage(
        imageUrl: snap['stories'][index],
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[AppConstants.shimmerBaseColor]!,
          highlightColor: Colors.grey[AppConstants.shimmerHighlightColor]!,
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: Colors.grey[300],
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
