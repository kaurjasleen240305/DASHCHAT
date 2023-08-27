import 'package:dash/assets/utils/colors.dart';
import 'package:dash/resource/firestore_methods.dart';
import 'package:dash/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dash/shared/follow_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile_Screen extends StatefulWidget {
  final String uid;
  const Profile_Screen({super.key,required this.uid});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
 bool isFollowing=false;
 int followers=0;
 int following=0;
 var userData={};
 var posts_no=0;
  @override void initState(){
    super.initState();
    getUsername();
  }

  void getUsername() async{
    var snap=await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
    var currentUser=await FirebaseAuth.instance.currentUser;
    userData=snap.data()!;
    followers=userData['followers'].length;
    following=userData['following'].length;
    var postnap=await FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: userData['uid']).get();
    posts_no=postnap.docs.length;
    isFollowing=snap.data()!['followers'].contains(FirebaseAuth.instance.currentUser!.uid);
  
   // posts_no=snap2.length
    setState(() {
      
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        backgroundColor:mobileBackgroundColor ,
        title:Text(userData['username']),
        centerTitle: false,
       ),
       body:ListView(
        children:[
          Padding(
            padding:const EdgeInsets.all(16) ,
          child:Column(children: [
               Row(children: [
                CircleAvatar(backgroundColor: Colors.amber,radius: 40,),
                Expanded(
                  flex: 1,
                child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                       buildStatColumn(posts_no, 'posts'),
                       buildStatColumn(followers, 'followers'),
                       buildStatColumn(following, 'following'),
                  ],),

                  )
               ],),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                children: [
                  FirebaseAuth.instance.currentUser!.uid==widget.uid?
                     FollowButton(
                          text: 'Sign Out',
                          backgroundColor: mobileBackgroundColor,
                          border_color: Colors.grey,
                          function: () async{
                              await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginScreen()));
                          },
                          textColor: primaryColor,
                     ):isFollowing?FollowButton(
                          text: 'Unfollow',
                          backgroundColor: Colors.white,
                          border_color: Colors.grey,
                          function: ()async{
                            await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                            setState(() {
                              isFollowing=false;
                              followers--;
                            });
                          },
                          textColor:Colors.black,
                     ):FollowButton(
                          text: 'Follow',
                          backgroundColor: blueColor,
                          border_color: Colors.grey,
                          function: ()async{
                              await FireStoreMethods().followUser(FirebaseAuth.instance.currentUser!.uid, userData['uid']);
                              setState(() {
                                isFollowing=true;
                                followers++;
                              });
                          },
                          textColor: primaryColor,
                     )
               ],),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:3),
                child:Text(userData['username'],style: TextStyle(fontWeight: FontWeight.bold),)
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:3),
                child:Text(userData['bio'])
              )
          ],
          ),),
    //      Padding(padding: EdgeInsets.all(value))
      const Divider(),
      
      FutureBuilder(
      future:FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo:widget.uid).get(),
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child:CircularProgressIndicator());
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: (snapshot.data! as dynamic).docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 1.5,childAspectRatio:1 ), 

          itemBuilder: (context,index){
            DocumentSnapshot snap=(snapshot.data! as dynamic).docs[index];
            return Container(
              child:Image(image:NetworkImage(snap['postUrl']),fit: BoxFit.cover,)
            );
          },
          );
      }
      )
        ]
       )
    );

  }
  Column buildStatColumn(int num,String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:MainAxisAlignment.center ,
      children: [
        Text(num.toString(),style: TextStyle(fontSize:22,fontWeight:FontWeight.bold),),
         Text(label,style: TextStyle(fontSize:15,fontWeight:FontWeight.w400,color:Colors.grey)),
      ],);
  }
}