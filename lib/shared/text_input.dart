import 'package:flutter/material.dart';

class Text_input extends StatelessWidget {
  
 
 final TextEditingController textEditingController;
 final bool isPass;
 final String hintText;
 final TextInputType textInputType;
 const Text_input({Key? key,required this.textEditingController,this.isPass=false,required this.hintText,required this.textInputType}):super(key:key);

  @override
  Widget build(BuildContext context) {
     final input_border=OutlineInputBorder(
          borderSide: Divider.createBorderSide(context)
        );
    return TextField(
      controller:textEditingController,
      decoration:InputDecoration(
        hintText: hintText,
        border:input_border,
        enabledBorder: input_border,
        filled:true,
        contentPadding: const EdgeInsets.all(8),
      ) ,
      keyboardType:textInputType ,
      obscureText: isPass,
      );
  }
}