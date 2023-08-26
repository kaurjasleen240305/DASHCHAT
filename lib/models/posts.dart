import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final List likes;
  final String postId;
  final DateTime date_pub;
  final String postUrl;
  final String profImage;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.date_pub,
    required this.postUrl,
    required this.profImage,
  }) ;

  static Post fromSnap(DocumentSnapshot snap){
      var snapshot=snap.data() as Map<String,dynamic>;
      return Post(
        description: snapshot['description'],
        uid:snapshot['uid'],
        username: snapshot['username'],
        likes:snapshot['likes'] ,
        date_pub:snapshot['date_pub'] ,
        postUrl: snapshot['postUrl'],
        profImage:snapshot['profImage'] ,
        postId: snapshot['postId'],
      );
  }

  Map<String,dynamic> toJson()=>{
    "description":description,
    "uid":uid,
    "likes":likes,
    "username":username,
    "postId":postId,
    "date_pub":date_pub,
    "postUrl":postUrl,
    "profImage":profImage,
  };

}