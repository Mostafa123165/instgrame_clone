import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/profile_view.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/info_about_post_widget.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_cubit.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shimmer/shimmer.dart';

class PostWidgetInSearchScreen extends StatelessWidget {
  const PostWidgetInSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (SearchCubit.get(context).searchController.text.isNotEmpty) {
          return FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').where('name', isGreaterThanOrEqualTo: SearchCubit.get(context).searchController.text.toUpperCase(),).get(),
              builder: (context, dynamic snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicatorWidget(
                        width: 20.w,
                        height: 20.h,
                        strokeWidth: 2.5.r,
                      ));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if(snapshot.data!.docs[index].id == UserResult.data!.token) return const SizedBox() ;
                    return itemSearch(snapshot:snapshot,index: index,context: context,uId: snapshot.data!.docs[index].id) ;
                  },
                );
              });
        }
        return FutureBuilder(
          future: FirebaseFirestore.instance.collection('posts').orderBy('dataTime').get(),
          builder: (context, dynamic snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicatorWidget(
                width: 20.w,
                height: 20.h,
                strokeWidth: 2.5.r,
              ));
            }
            return StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return postWidget(index: index, snapshot: snapshot,context: context);
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(
                  (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
              mainAxisSpacing: 0.5.h,
              crossAxisSpacing: 0.5.w,

            );
          },
        );
      },
    );
  }



}

Widget itemSearch({required snapshot , required int index , required String uId, context }) =>  ListTile(
  leading: Padding(
    padding: EdgeInsets.only(right: 5.w),
    child: CachedNetworkImage(
      imageUrl: snapshot.data!.docs[index]['image'],
      imageBuilder: (context, imageProvider) =>
          CircleAvatar(
            radius: 28.r,
            backgroundColor: Colors.transparent,
            backgroundImage: imageProvider,
          ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor:
        Colors.grey[AppConstants.shimmerBaseColor]!,
        highlightColor: Colors
            .grey[AppConstants.shimmerHighlightColor]!,
        child: CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.grey[300],
        ),
      ),
      errorWidget: (context, url, error) =>
      const Icon(Icons.error),
    ),
  ),
  contentPadding: EdgeInsets.only(
      bottom: 10.h, right: 10.w, left: 10.w),
  title: Text(
    snapshot.data!.docs[index]['name'],
    style: Styles.textStyle16,
  ),
  onTap: () {
    Components().navigatorAndPush(context: context, widget: ProfileScreen(uId: uId, fromMyProfile: false));
  },
);

Widget postWidget({required var snapshot, required int index , context }) =>
    InkWell(
      onTap : (){
        String postId = snapshot.data!.docs[index].id ;
        Components().navigatorAndPush(context: context, widget: InfoProfilePostWidget(postId:postId,showFollow: false), pageTransitionType: PageTransitionType.rightToLeft,duration: 230);
      } ,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: snapshot.data!.docs[index]['images'][0],
        placeholder: (context, _) => Shimmer.fromColors(
          baseColor: Colors.grey[AppConstants.shimmerBaseColor]!,
          highlightColor: Colors.grey[AppConstants.shimmerHighlightColor]!,
          child: Container(
            padding: EdgeInsets.zero,
            color: Colors.grey,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

