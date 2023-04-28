import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:shimmer/shimmer.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({Key? key , this.foundSnap =true, this.imageUrl = ''  ,required this.snap , required this.radius}) : super(key: key);
  final snap ;
  final bool foundSnap ;
  final double radius ;
  final  String imageUrl ;
  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: foundSnap ? snap['image'] : imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[AppConstants.shimmerBaseColor]!,
        highlightColor: Colors.grey[AppConstants.shimmerHighlightColor]!,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey[300],
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
