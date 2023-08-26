import 'package:dash/assets/utils/colors.dart';
import 'package:dash/assets/utils/utils.dart';
import 'package:dash/providers/user.dart';
import 'package:dash/resource/firestore_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Add_post_screen extends StatefulWidget {
  const Add_post_screen({super.key});

  @override
  State<Add_post_screen> createState() => Add_post_screenState();
}

class Add_post_screenState extends State<Add_post_screen> {
  Uint8List? _file;
  bool isLoading=false;
  final TextEditingController _desc_controller=TextEditingController();

   void _selectImage(BuildContext parentContext) async{
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
                        _file=file;
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
                    _file = file;
                  });
                }),
                SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
                ]
              );
            }
            
        );
   }
   

   void postImage(String uid,String username,String profImage) async{
      setState(() {
        isLoading=true;
      });
      try{
        String res=await FireStoreMethods().uploadPost(
          _desc_controller.text, _file!, uid, username, profImage);
          if(res=="Success"){
            setState(() {
              isLoading=false;
            });
          }
          else{
            print(res);
          }
      }
      catch(err){
        setState(() {
          isLoading=false;
        });
        print(err.toString());
      }
   }

   void clearImage(){
    setState(() {
      _file=null;
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
                  onPressed: () => postImage(
                    userProvider.getUser.uid,
                    userProvider.getUser.username,
                    userProvider.getUser.profile_pic,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
         ),

         body:Column(children: <Widget>[
          isLoading? const LinearProgressIndicator()
          :const Padding(padding: EdgeInsets.only(top:0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.amber,),
              SizedBox(
                width:400,
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
                      height: 45.0,
                      width: 45.0,
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