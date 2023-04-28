import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/chat_screen_body.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/Styles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(UserResult.data!.name,style: Styles.textStyle22,),
      ),
      body: const ChatScreenBody(),
    );
  }
}

