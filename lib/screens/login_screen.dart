import 'package:dash/assets/colors.dart';
import 'package:dash/shared/text_input.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email_controller=TextEditingController();
  final TextEditingController pass_controller=TextEditingController();
  @override
  void dispose(){
    super.dispose();
    email_controller.dispose();
    pass_controller.dispose();
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
            Container(
              child:const Text('Log In',style: TextStyle(color:Colors.white,fontSize:18),),
              width:double.infinity,
              alignment:Alignment.center,
              padding:const EdgeInsets.symmetric(vertical:18),
              decoration: const ShapeDecoration(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                 color: blueColor,
               ),
            ),
            //to signup
            SizedBox(height:15,),
            Flexible(child: Container(
              height:15,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                child:Text('Dont have an account?   ',style:TextStyle(color:blueColor)),
                padding:const EdgeInsets.symmetric(vertical:8,),
              ),
            GestureDetector
            (
              onTap:(){} ,
              child: Container(
         //     width:400,
              child:Text('Sign Up',style:TextStyle(color:blueColor)),
              padding:const EdgeInsets.symmetric(vertical:8,),
              ),),
            ],)
          ],),
         

          ),
        ),
        
        );
  }
}