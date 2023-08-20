import 'package:flutter/material.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('HOME PAGE',style: TextStyle(color:Colors.white),),
        backgroundColor:Colors.black38,
      ),
    );
  }
}