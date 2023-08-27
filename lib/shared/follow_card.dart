import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {

  final Function()?  function;
  final Color backgroundColor;
  final Color border_color;
  final String text;
  final Color textColor;
  const FollowButton({super.key,required this.backgroundColor,required this.text,required this.border_color,required this.textColor,required this.function});

  @override
  Widget build(BuildContext context) {
      return Container(
        padding:const EdgeInsets.only(top:20),
        child:TextButton(
          onPressed:function ,
          child:Container(
            decoration: BoxDecoration(
              color:backgroundColor,
              border:Border.all(color:border_color),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child:Text(text,style:TextStyle(color:textColor,fontWeight: FontWeight.bold)),
            width:250 ,
            height: 27,
          )
        )
      );
  }
}