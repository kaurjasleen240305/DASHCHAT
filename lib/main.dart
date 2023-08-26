import 'package:dash/assets/utils/colors.dart';
import 'package:dash/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:dash/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=>UserProvider(), )
      ],
    child:MaterialApp(
      title:'SPLASH SCREEN',
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home:Splash_screen_created(),
    ),);
  }
}
