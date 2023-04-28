import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({Key? key , this.strokeWidth = 0.6 , required this.width , required this.height}) : super(key: key);
  final double strokeWidth ;
  final double width  ;
  final double height ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width , height:height ,child: CircularProgressIndicator(strokeWidth:strokeWidth,));
  }
}
