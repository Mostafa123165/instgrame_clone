import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_cubit.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/profile_appar_widget.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/profile_info_widget.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/profile_posts_widget.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/widgets/profile_stories_widget.dart';

import 'package:instgrameclone/core/uttils/constants.dart';

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({Key? key, required this.uId }) : super(key: key);
  final String uId ;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(uId).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding:  AppConstants.defaultPadding,
          child: CustomScrollView(
            controller: ProfileCubit.get(context).profileController,
            slivers: [
             ProfileApparWidget(uId: uId ,snap :snapshot.data ,),
             SliverToBoxAdapter(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:[
                    ProfileInfoWidget(snap: snapshot.data,uId: uId),
                    StoresWidget(snap: snapshot.data,uid:uId),
                 ],
               ),
             ),
             ProfilePostsWidget(snap: snapshot.data,),
            ],
          )
        );
      }
    );
  }
}

