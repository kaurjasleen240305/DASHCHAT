import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:dash/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dash/screens/login_screen.dart';
import 'dart:async';
class Splash_screen_created extends StatefulWidget {
  const Splash_screen_created({super.key});

  @override
  State <Splash_screen_created> createState() =>  _Splash_screen_createdState();
}

class _Splash_screen_createdState extends State <Splash_screen_created> {
  ParticleOptions particles=const ParticleOptions(
    baseColor: Colors.blueAccent,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );
  @override 
  void initState(){
    super.initState();
    Timer(Duration(seconds:10),()=>
       Navigator.pushReplacement(context,MaterialPageRoute(
        builder:(context)=>LoginScreen()
       ))
    );
  }
  @override 
  Widget build(BuildContext context){

    return Scaffold(
      
      body:Container(
      color:Colors.black,
      height:double.infinity,
      width:double.infinity,
      child:Center(
        
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/Dash_logo.png',height:200,width: 250,scale:3.0),
          Text('DashChat',style: TextStyle(color: Colors.pinkAccent,fontFamily:'Vegan' ,fontWeight: FontWeight.bold,fontSize:25),),
   //       Text('DASHCHAT',style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
          ]
        )
      ,)
    ),);
  }

}