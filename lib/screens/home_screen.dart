import 'package:dash/assets/utils/colors.dart';
import 'package:dash/screens/add_post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
   String username="";
   int open=0;
   late PageController pageController;
   
   @override 
   void initState(){
    super.initState();
    getUsername();
    addData();
    pageController=PageController();
   }

   @override
   void dispose(){
    super.dispose();
    pageController.dispose();
   }
   void getUsername() async{
    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username=(snap.data() as Map<String,dynamic>)['username'];
    });

   }

   void  navigation_tapped(int page) async{
      pageController.jumpToPage(page);
   }

   addData() async{
    UserProvider _userProvider=Provider.of(context,listen:false);
    await _userProvider.refreshUser();
   }
   void onPageChange(int page){
    setState(() {
      open=page;
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (
        title:Text("$username"),
      ),
      body:PageView(
        children: [
             Text('feed'),
            Text('search'),
            Add_post_screen(),
            Text('notif'),
            Text('profile'),
        ],
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged:onPageChange ,
        ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
        BottomNavigationBarItem(icon:Icon(Icons.home,color:open==0?primaryColor:secondaryColor),label:'',backgroundColor: primaryColor),
        BottomNavigationBarItem(icon:Icon(Icons.search,color:open==1?primaryColor:secondaryColor),label:'',backgroundColor: primaryColor),
        BottomNavigationBarItem(icon:Icon(Icons.add_circle,color:open==2?primaryColor:secondaryColor),label:'',backgroundColor: primaryColor),
        BottomNavigationBarItem(icon:Icon(Icons.favorite,color:open==3?primaryColor:secondaryColor),label:'',backgroundColor: primaryColor),
        BottomNavigationBarItem(icon:Icon(Icons.person,color:open==5?primaryColor:secondaryColor),label:'',backgroundColor: primaryColor),
      ],
      onTap:navigation_tapped ,
      ),
    );
  }
}