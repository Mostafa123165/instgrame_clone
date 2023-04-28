import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/message_screen_body.dart';
import 'package:instgrameclone/Feature/chats/presentation/views/widgets/message_screnn_appar.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key , required this.receiverId , required this.receiverImage ,required this.receiverName ,}) : super(key: key);
  final String receiverId ;
  final String receiverName ;
  final String receiverImage ;
  @override
  Widget build(BuildContext context) {
    print(receiverId);
    return  Scaffold(
      appBar: messageScreenAppar(name:receiverName ,image: receiverImage),
      body:  MessageScreenBody(receiverId:receiverId , receiverName: receiverName ,receiverImage: receiverImage),
    );
  }
}
