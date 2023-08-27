import 'package:flutter/material.dart';

class Like_animate extends StatefulWidget {

  //CONSTRUCTOR ARGUMENTS\
  final Widget child;
  final bool isAnimated;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  const Like_animate({super.key,
   required this.child,
   required this.isAnimated,
   this.duration=const Duration(milliseconds: 150),
   this.onEnd,
   this.smallLike=false,
  });

  @override
  State<Like_animate> createState() => _Like_animateState();
}

class _Like_animateState extends State<Like_animate> with SingleTickerProviderStateMixin{
  late AnimationController cont;
  late Animation<double> scale;

   void initState(){
    super.initState();
    cont=AnimationController(vsync: this,duration:Duration(milliseconds: widget.duration.inMilliseconds ~/2));
    scale=Tween<double>(begin: 1,end:1.2).animate(cont);
   }

  @override 
  void didUpdateWidget(covariant Like_animate oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimated!=oldWidget.isAnimated){
      startAnimation();
    }
  }

  startAnimation() async{
    if(widget.isAnimated|| widget.smallLike){
      await cont.forward();
      await cont.reverse();
      await Future.delayed(const Duration(milliseconds: 200,));
      if(widget.onEnd!=null){
        widget.onEnd!();
      }
    }
  }

  @override  
  void dispose(){
    super.dispose();
    cont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale:scale,
      child:widget.child,
    );
  }
}