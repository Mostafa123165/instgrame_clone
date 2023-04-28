import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {

  final Widget child ;
  final Duration duration ;
  final bool smaleLike ;
  final bool isAnimating ;
  final VoidCallback? onEnd;
  final double scaleEnd ;
  const LikeAnimation({
    Key? key,
    required this.child ,
    required this.smaleLike,
    required this.isAnimating,
    required this.onEnd ,
    this.scaleEnd = 1.2 ,
    this.duration = const Duration(milliseconds: 150),
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin {

  late AnimationController controller ;
  late Animation<double>scale ;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this ,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1 , end: widget.scaleEnd).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {

    if(widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smaleLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    controller.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  ScaleTransition(
      scale: scale ,
      child: widget.child,
    );
  }
}
