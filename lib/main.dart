import 'package:dash/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:dash/screens/sign_up_screen.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:dash/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'SPLASH SCREEN',
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home:Sign_up_screen(),
    );
  }
}
