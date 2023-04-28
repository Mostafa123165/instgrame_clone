import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/widgets/circle_avatare_widget.dart';

class NotificationScreenBody extends StatelessWidget {
  const NotificationScreenBody({Key? key , required this.snap}) : super(key: key);
  final snap ;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snap.data!.docs.length,
      itemBuilder: (BuildContext context, int index) {
        if(snap == null ) {
          return const SizedBox() ;
        }
        return ListTile (
          leading: CircleAvatarWidget(
            radius: 25.r,
            snap: null ,
            imageUrl : snap.data!.docs[index]['image'] ,
            foundSnap: false,
          ),
          title: Text(
            snap.data!.docs[index]['name'],
            style: Styles.textStyle16,
          ),
          subtitle:  Text(
            snap.data!.docs[index]['text'],
            style: Styles.textStyle16,
          ),
          onTap: () {
            // Handle notification tap
          },
        );
      },
    );
  }
}

