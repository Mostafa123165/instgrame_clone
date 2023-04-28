
abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetMessagesSuccessState extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class ClearMessages extends ChatState {}
