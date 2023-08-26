import 'dart:typed_data';
import 'package:dash/assets/utils/utils.dart';
import 'package:dash/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dash/shared/text_input.dart';
import 'package:dash/assets/utils/colors.dart';
import 'package:dash/resource/auth.dart';
import 'package:image_picker/image_picker.dart';


class Sign_up_screen extends StatefulWidget {
  const Sign_up_screen({super.key});

  @override
  State<Sign_up_screen> createState() => _Sign_up_screenState();
}

class _Sign_up_screenState extends State<Sign_up_screen> {
  final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passController=TextEditingController();
  final TextEditingController _bioController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();
  Uint8List? _image;
  bool loading=false;

  @override 
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  selectImage() async{
      Uint8List im=  await pickImage(ImageSource.camera);
      setState(() {
        _image=im;
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
            Container(
            child:Text('DashChat',style: TextStyle(color:Colors.white,fontFamily:'Vegan' ,fontWeight: FontWeight.bold,fontSize:30),),),
            const SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                _image!=null? CircleAvatar(
                  radius:60,
                  backgroundImage: MemoryImage(_image!),
                ):

                Container(
                  height:100,
                  width:100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(55),color: Colors.white),
            //      color: Colors.white,
                  child:Image.asset('lib/assets/images/nopic.jpg'),
                  ),
                Positioned(
                  bottom:-10,
                  left:70,
                  child: IconButton(onPressed: (selectImage), icon: const Icon(Icons.add))),
              ],
            ),
            const SizedBox(height:30),
            //text field for email
            Text_input(textEditingController:_emailController, hintText: "Enter Your Email", textInputType:TextInputType.emailAddress),
            const SizedBox(
              height: 30,
            ),
             //text field for password
             Text_input(textEditingController:_passController, hintText: "Enter Your Password", textInputType:TextInputType.text,isPass: true,),
             const SizedBox(
              height: 30,
            ),
             Text_input(textEditingController:_bioController, hintText: "Enter About Yourself", textInputType:TextInputType.text,),
             const SizedBox(
              height: 30,
            ),
             Text_input(textEditingController:_usernameController, hintText: "Enter Username", textInputType:TextInputType.text,),
             const SizedBox(
              height: 30,
            ),
            //button login
            InkWell(
              onTap: ()async{
                setState(() {
                  loading=true;
                });
              String res=await Authentication().sign_up(email: _emailController.text, password: _passController.text, username: _usernameController.text, bio: _bioController.text,file:_image!);
              print(res);
              print('/n');
              print('/n');
              setState(() {
                loading=false;
              });
              },
             child:Container(
              child:
              loading? const Center(child:CircularProgressIndicator(color:primaryColor),) :const Text('Register',style: TextStyle(color:Colors.white,fontSize:18),),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:const EdgeInsets.symmetric(vertical:8,horizontal: 8),
                  child:Text('Already have an account?',style:TextStyle(color:blueColor)),
                ),
                GestureDetector(
                  onTap:()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>const LoginScreen() )),
                  child:Container(
                    padding:EdgeInsets.symmetric(vertical:8,horizontal:6),
                    child:const Text('Login',style:TextStyle(fontWeight:FontWeight.bold,color:blueColor)),
                  )
                ),
                
              ],
            )
            
          ],),
         

          ),
        ),
        
        );
  }
}