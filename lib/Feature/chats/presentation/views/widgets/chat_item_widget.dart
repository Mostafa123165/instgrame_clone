import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/message_view.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:instgrameclone/core/widgets/circle_avatare_widget.dart';
import 'package:page_transition/page_transition.dart';

class ChatItemsWidget extends StatelessWidget {
  const ChatItemsWidget({Key? key , required this.snap , required this.receiverId,required this.name,}) : super(key: key);
  final snap ;
  final String receiverId  ;
  final String name ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.h,
      child: Padding(
        padding:AppConstants.defaultPadding,
        child: InkWell(
          onTap: (){
            Components().navigatorAndPush(context: context, widget:  MessageScreen(receiverId: receiverId,receiverName: snap['name'],receiverImage: snap['image']),pageTransitionType: PageTransitionType.bottomToTop,duration: AppConstants.duration);
          },
          child: Row(
              children: [
                CircleAvatarWidget(snap: snap, radius: 28.r,),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snap['name'],
                        style: Styles.textStyle14,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              snap['lastMessage'],
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Text(
                            FeedCubit.get(context).timeAddPost(startDate: snap['publishedTime'],endDate:DateTime.now()),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
