import 'package:dash/assets/utils/colors.dart';
import 'package:dash/assets/utils/utils.dart';
import 'dart:typed_data';
import 'package:dash/providers/user.dart';
import 'package:dash/resource/firestore_methods.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:buffer/buffer.dart';

class Add_post_screen extends StatefulWidget {
  const Add_post_screen({super.key});

  @override
  State<Add_post_screen> createState() => Add_post_screenState();
}

class Add_post_screenState extends State<Add_post_screen> {
  String username="";
  String uid="";
 // var cx=rootBundle.load('lib/assets/images/Dash_logo.png');
  Uint8List? _file;
  bool isLoading=false;
  final TextEditingController _desc_controller=TextEditingController();


  @override 
   void initState(){
    super.initState();
    getUsername();
   }
  
  void getUsername() async{
    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data()as Map<String,dynamic>)['username'];
      uid=(snap.data()as Map<String,dynamic>)['uid'];
    });
   }
   void _selectImage(BuildContext parentContext) async{
   //      final AssetBundle rootBundle = ;
      //    ByteBuffer get buffer => _typedBuffer.buffer;
         ByteData x=await rootBundle.load('lib/assets/images/Dash_logo.png');
        // print(x);
        
          return showDialog(
            context: parentContext, 
            builder: (BuildContext context){
              return SimpleDialog(
                title:const Text('Create a Post'),
                children:<Widget>[
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: const Text('Take a Photo'),
                    onPressed: ()async{
                      Navigator.pop(context);
                      Uint8List file=await pickImage(ImageSource.camera);
                      setState(() {
                         _file=x.buffer.asUint8List();
                      });
                    },
                  ),
                  SimpleDialogOption(
                    padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                     _file=x.buffer.asUint8List();
                  });
                }),
                SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
               SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("MY OWN"),
             onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await x.buffer.asUint8List();
                  setState(() {
                     _file=file;
                  });
                }
            )
                ]
              );
            }
            
        );
   }
   

   void postImage(String uid,String username) async{
   //   _file=await rootBundle.load('lib/assets/')
      print('Hi');
      setState(() {
        isLoading=true;
      });
      try{
        if(_file=='null'){
          print("NUllllllllllllllllll");
        }
        else{
          print("Not Nulllllllllllllll");
        }
        String res=await FireStoreMethods().uploadPost(
          _desc_controller.text, _file!, uid, username);
          if(res=="Success"){
            print("SUCCESS SUCCESS SUCCESS");
            setState(() {
              isLoading=false;
            });
          }
          else{
            print("ERROR");
          }
      }
      catch(err){
        setState(() {
          isLoading=false;
        });
        print("ERROR");
      }
   }

   void clearImage(){
    setState(() async{
      ByteData x=await rootBundle.load('lib/assets/images/Dash_logo.png');
       _file=x.buffer.asUint8List();
    });
   }


  @override 
  void dispose(){
    super.dispose();
    _desc_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final UserProvider userProvider=Provider.of<UserProvider>(context);
      return _file==null?Center(child: IconButton(icon: const Icon(Icons.upload),onPressed: ()=>_selectImage(context),)):
      Scaffold(
         appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed:clearImage,),
          title:Text('Post to'),
          centerTitle: false,
          actions: <Widget>[
                TextButton(
                  onPressed: () => {print(username),postImage(
                    uid,
                   username,
                  ),
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
         ),

         body:Column(children: <Widget>[
          isLoading? const LinearProgressIndicator(color: primaryColor,)
          :const Padding(padding: EdgeInsets.only(top:0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.amber,),
              SizedBox(
                width:200,
                child:TextField(
                  controller: _desc_controller,
                  decoration: const InputDecoration(
                    hintText: "Write a Caption...",
                    border:InputBorder.none
                  ),
                  maxLines: 8,
                  )
              ),
              SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                        ),
                      ),
                    ),

            ]
              )
            ]
            ,)
         );

  }
}