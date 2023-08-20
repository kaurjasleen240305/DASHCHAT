import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:dash/screens/splash_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'SPLASH SCREEN',
      theme:ThemeData(
        primarySwatch: Colors.green,
      ),
      home:Splash_screen_created(),

    );
  }
}
