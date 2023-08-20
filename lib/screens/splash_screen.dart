import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:flutter/material.dart';
import 'package:dash/screens/home_screen.dart';
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
        builder:(context)=>MyHomePage()
       ))
    );
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/Dash_logo.png',height:200,width: 200,scale:2.5),
          Text('DASHCHAT'),
          ]
        )
      ,)
    );
  }

}