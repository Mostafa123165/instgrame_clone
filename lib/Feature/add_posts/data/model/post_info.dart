import 'package:instgrameclone/core/data_app/user.dart';

class PostInfo {
  final String description;
  final List<dynamic> images;
  final String uIdPostOwner;
  final String uIdPost;
  final String ownerName;
  final String dataTime;
  final String ownerUId;
  final List<String> likes;
  final List<String> comments;

  PostInfo(
      {required this.description,
      required this.images,
      required this.uIdPostOwner,
      required this.uIdPost,
      required this.ownerName,
      required this.dataTime,
      required this.likes ,
      required this.comments,
      required this.ownerUId,
      });

   static Map<String, dynamic> toMap(PostInfo postInfo) {
    return {
      "description": postInfo.description,
      "images": postInfo.images,
      "uIdPostOwner": postInfo.uIdPostOwner,
      "uIdPost": postInfo.uIdPost,
      "ownerName": postInfo.ownerName,
      "dataTime": postInfo.dataTime,
      "likes" : postInfo.likes ,
      "comments" : postInfo.comments ,
      "ownerUid" : postInfo.ownerUId ,
      "image" : UserResult.data!.image ,
    };
  }
}
