import 'package:dash/assets/utils/colors.dart';
import 'package:dash/resource/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dash/shared/comments_card.dart';


class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key,required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String username="";
  String userId="";
  final TextEditingController comm_controller=TextEditingController();



   @override 
   void initState(){
    super.initState();
    getUsername();
   }
   
   @override
   void dispose(){
    super.dispose();
    comm_controller.dispose();
   }

   void getUsername() async{
    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data() as Map<String,dynamic>)['username'];
      userId=(snap.data() as Map<String,dynamic>)['uid'];
    });
   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //APPBAR
       appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title:const Text('Comments'),
        centerTitle:false,

       ),
 

     //LIST OF COMMENTS
     body:StreamBuilder(
      stream:FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').orderBy('date_pub',descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:CircularProgressIndicator());
        }
        return ListView.builder(itemCount:(snapshot.data! as dynamic).docs.length ,itemBuilder: (context,index)=>CommentCard(
            snap:(snapshot.data! as dynamic).docs[index]
        ) );
      },
     ),
      
      

      //BOTTOM NAVIGATION BAR
       bottomNavigationBar:SafeArea(
          child:Container(
            height:kToolbarHeight,
            margin:EdgeInsets.only(left: 5,bottom:5),
            padding:const EdgeInsets.only(
              left:16,right:8,
            ),
            child:Row(children: [
              CircleAvatar(backgroundColor:Colors.red,radius:15),
              Expanded(
              child:TextField(
                controller: comm_controller,
                decoration:InputDecoration(
                  hintText: '  Comment as ${username}...',
                  border:InputBorder.none,
                ) ,
              )),
              InkWell(
                onTap:()async{
                 await FireStoreMethods().postComment(widget.snap['postId'],comm_controller.text,userId, username);
                 setState(() {
                   comm_controller.text="";
                 });
                },
                child:Container(
                  padding:const EdgeInsets.symmetric(vertical: 8,horizontal:8 ),
                  child:const Text('Post',style:TextStyle(color:Colors.blueAccent))
                )
              )
            ],)
          )
       ) ,
    );
  }
}
