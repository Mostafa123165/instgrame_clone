import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/controller/feed_cubit.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/feed_screen_appar.dart';
import 'package:instgrameclone/Feature/instgram_main/presentation/views/widgets/feed_screen_body.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FeedCubit.get(context).updateDeviceToken();
    return  Scaffold(
      appBar:  feedScreenAppar(context) ,
      body: const FeedScreenBody(),
    );
  }
}

