import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  final String email;
  final String uid;
  final String profile_pic;
  final String username;
  final String bio;
  final List followers;
  final List following; 
  const User({
    required this.email,
    required this.uid,
    required this.profile_pic,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  

  Map<String,dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "email":email,
    "profile_pic":profile_pic,
    "bio":bio,
    "followers":followers,
    "following":following,
  };
   static User fromSnap(DocumentSnapshot snapshot){
     var snap=snapshot.data() as Map<String,dynamic> ;
     return User(
      email:snap["email"],
      uid:snapshot['uid'],
      profile_pic:snapshot[' profile_pic'],
      username:snapshot['username'] ,
      bio:snapshot['bio'],
      followers:['followers'],
      following:['following'],
     );
 
  }
}