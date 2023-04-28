import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/notification/presentation/views/widgets/notitfication_body.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/strings.dart';
import 'package:instgrameclone/core/widgets/circular_progress_indicator_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: FirebaseFirestore.instance.collection('notifications').doc(UserResult.data!.token).collection('notify').get(),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) =>Scaffold(
        appBar: AppBar(
            title: Text(
              AppStrings.notification ,
              style: Styles.textStyle22 ,
            )
        ),
        body: snapshot.data == null ? Center(child: CircularProgressIndicatorWidget(width: 20.w, height: 20.h,strokeWidth: 2.5.r,)) :  NotificationScreenBody(snap: snapshot),
      ),
    );
  }
}
