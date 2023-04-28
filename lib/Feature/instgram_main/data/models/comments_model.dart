import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String image ;
  final String name ;
  final String uId ;
  final String text ;
  final int dataPublished;
  final List<String> likes;

  const CommentModel(
      {
      required this.image,
      required this.name,
      required this.uId,
      required this.text,
      required this.dataPublished,
      required this.likes,
      });


   Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "text": text,
      "uId": uId,
      "dataPublished": dataPublished,
      "likes": likes,
    };
  }

  @override
  List<Object?> get props => [
    image, name, uId, text, dataPublished, likes,
  ] ;
}