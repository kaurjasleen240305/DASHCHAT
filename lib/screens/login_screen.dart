import 'package:dash/assets/utils/colors.dart';
import 'package:dash/screens/home_screen.dart';
import 'package:dash/screens/sign_up_screen.dart';
import 'package:dash/shared/text_input.dart';
import 'package:flutter/material.dart';
import 'package:dash/resource/auth.dart';
import 'dart:typed_data';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email_controller=TextEditingController();
  final TextEditingController pass_controller=TextEditingController();
  bool loading=false;
  bool error=false;
  String? res;
  @override
  void dispose(){
    super.dispose();
    email_controller.dispose();
    pass_controller.dispose();
  }

  void loginUser() async{
    setState(() {
      loading=true;
      error=false;
    });
    res=await Authentication().login(email: email_controller.text,password:pass_controller.text );
    if(res=="Success"){
       
    }
    else {
      error=true;
      if(res=='user-not-found'){
        res="NO SUCH USER EXISTS PLEASE REGISTER ";
      }
    }
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Container(
          padding:const EdgeInsets.symmetric(horizontal:32),
          width:double.infinity,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //dashchat  logo
            Flexible(child:Container(
              height:150,
            )),
            Image.asset('lib/assets/images/Dash_logo.png',height:200,width:200,scale:3.5),
            Container(
            child:Text('DashChat',style: TextStyle(color:Colors.white,fontFamily:'Vegan' ,fontWeight: FontWeight.bold,fontSize:30),),),
            const SizedBox(
              height: 64,
            ),
            //text field for email
            Text_input(textEditingController:email_controller, hintText: "Enter Your Email", textInputType:TextInputType.emailAddress),
            const SizedBox(
              height: 30,
            ),
             //text field for password
             Text_input(textEditingController:pass_controller, hintText: "Enter Your Password", textInputType:TextInputType.text,isPass: true,),
             const SizedBox(
              height: 30,
            ),
            //button login
            InkWell(
              onTap:loginUser,
            child:Container(
              child:!loading? const Text('Log In',style: TextStyle(color:Colors.white,fontSize:18),):const CircularProgressIndicator(color:primaryColor),
              width:double.infinity,
              alignment:Alignment.center,
              padding:const EdgeInsets.symmetric(vertical:18),
              decoration: const ShapeDecoration(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                 color: blueColor,
               ),
            ),),
            //to signup
            SizedBox(height:15,),
            Flexible(child: Container(
              height:15,
            )),
            error? Container(
              width:400,
              height:50,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),border: Border.all(color:Colors.redAccent),color: Colors.redAccent),
              child:Center(child:Text('$res',style:TextStyle(color:primaryColor,fontSize:15)))):Text(" "),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                child:Text('Dont have an account?   ',style:TextStyle(color:blueColor)),
                padding:const EdgeInsets.symmetric(vertical:8,),
              ),
            GestureDetector
            (
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>Sign_up_screen()));
              } ,
              child: Container(
              padding:const EdgeInsets.symmetric(vertical:8,),
              child:Text('Sign Up',style:TextStyle(color:blueColor,)),
              ),),
            ],)
          ],),
          ),
        ),
        
        );
  }
}