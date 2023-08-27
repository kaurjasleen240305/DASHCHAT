import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dash/shared/like_widget.dart';
import 'package:flutter/material.dart';
import 'package:dash/models/users.dart' as model;
import 'package:dash/providers/user.dart';
import 'package:dash/resource/firestore_methods.dart';
import 'package:dash/assets/utils/colors.dart';
import 'package:dash/assets/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key,required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}



class _PostCardState extends State<PostCard> {
 bool isLikeAnimating=false;
 late String userid;
// final Widget.widget.snap=super.Widget.widget.snap;
  

   @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async{
    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      userid=(snap.data() as Map<String,dynamic>)['uid'];
    });

   }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color:mobileBackgroundColor,
      padding:const EdgeInsets.symmetric(vertical:10),
      child:Column(children: [
        Container(
          padding:const EdgeInsets.symmetric(vertical: 4,horizontal: 0),
          child:Row(
             children:[
              CircleAvatar(radius:15,backgroundColor: Colors.red,),
              Expanded(
                child: Padding(padding:const EdgeInsets.only(left:10),child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text(widget.snap['username'],style:TextStyle(fontWeight: FontWeight.bold)),

                ],)),
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder:(context)=>Dialog(
                      child:ListView(
                        padding: EdgeInsets.symmetric(vertical:16),
                        shrinkWrap: true,
                        children: [
                          'Delete',
                        ].map((e)=>InkWell(
                          onTap: (){},
                          child:Container(padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                            child:Text(e),
                          ),
                        )).toList(),
                      )
                  ),);
                }, icon: const Icon(Icons.more_vert)),
             ]
          ),
        ),
          //Post
          GestureDetector(
            onDoubleTap:() async{
              await FireStoreMethods().likePost(widget.snap['postId'],userid,widget.snap['likes']);
              setState(() {
                isLikeAnimating=true;
              });
            } ,
          child:Stack(
            alignment: Alignment.center,
         children:[SizedBox(
          height:300,
          width:double.infinity,
          child:Image.network(widget.snap['postUrl'],
          fit:BoxFit.cover),
          ),
          AnimatedOpacity(opacity:isLikeAnimating?1:0 , duration:const Duration(milliseconds: 200),
          child:Like_animate(child: const Icon(Icons.favorite,color: Colors.white,size:100), isAnimated: isLikeAnimating,duration:const Duration(milliseconds: 4),onEnd:(){
            setState(() {
              isLikeAnimating=false;
            });
          } ,)),
          ],
          )),
        //Likes+comments
        Row(
          children:[
        Like_animate( isAnimated: widget.snap['likes'].contains(userid),
            smallLike: true,
             child:IconButton(onPressed: ()async{
             await  FireStoreMethods().likePost(widget.snap['postId'],userid,widget.snap['likes']);
              setState(() {
                isLikeAnimating=true;
              });
             }, icon:(widget.snap['likes'].contains(userid))?
             const Icon(Icons.favorite ,color:Colors.red):const Icon(
              Icons.favorite_border,),
             ),),
             IconButton(onPressed: (){}, icon:Icon(Icons.comment_outlined) ,color:primaryColor),
              IconButton(onPressed: (){}, icon:Icon(Icons.send) ,color:primaryColor),
              Expanded(child:Align(
                alignment:Alignment.bottomRight,
                child: IconButton(icon:Icon(Icons.bookmark_border),onPressed:(){} ,)
              ,) ),
          ]
        ),
        //Desc
       Container(
          padding: const EdgeInsets.symmetric(horizontal:10),
          child:Column(
            mainAxisSize:MainAxisSize.min ,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Text('${widget.snap['likes'].length} likes',style:Theme.of(context).textTheme.bodyText2,textAlign: TextAlign.right,),
             Container(width:double.infinity,padding: const EdgeInsets.only(top:8),
            child:RichText(
              text: TextSpan(
                 style:const TextStyle(color:primaryColor),
                 children:[
                  TextSpan(
                    text:widget.snap['username'],
                    style:const TextStyle(fontWeight: FontWeight.bold,),
                  ),
                  TextSpan(
                    text:'  ${widget.snap['description']}',
                    style:const TextStyle(fontWeight: FontWeight.bold,),
                  ),

                 ]
              )
            ),),
          InkWell(
            onTap: (){},
            child:Container(
              padding: const EdgeInsets.symmetric(vertical:6),
              child:Text('View all 200 comments',style:TextStyle(
                color:secondaryColor,
                fontSize: 16,
              ))
            )),
            //Date of post
            Container(
              padding: const EdgeInsets.symmetric(vertical:6),
              child:Text(DateFormat.yMMMd().format(widget.snap['date_pub'].toDate()),style:TextStyle(
                color:secondaryColor,
                fontSize: 16,
              ))
            )
          ],)
        )
      
      ],)
      );
  }
}