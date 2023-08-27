import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/assets/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dash/shared/post_card.dart';

class All_Post_Screen extends StatefulWidget {
  const All_Post_Screen({super.key});

  @override
  State<All_Post_Screen> createState() => _All_Post_ScreenState();
}

class _All_Post_ScreenState extends State<All_Post_Screen> {
  @override
  Widget build(BuildContext context) {
       final width=250;
       return Scaffold(
         backgroundColor: mobileBackgroundColor,
         appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title:Text('DashChat',style: TextStyle(color:primaryColor,fontFamily:'Vegan' ,fontWeight: FontWeight.bold,fontSize:25),),
          actions: [
            IconButton(onPressed: (){}, icon:const Icon(Icons.messenger_outline),color: primaryColor,)
          ],
         ),
         body:StreamBuilder(
          stream:FirebaseFirestore.instance.collection('posts').snapshots(),
          builder:(context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child:CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(ctx,index)=>Container(
                    margin: EdgeInsets.symmetric(horizontal: 2,vertical: 20),
                    child:PostCard(snap:snapshot.data!.docs[index].data(),)
              ,)
               );
          }
         )
);
  }
}