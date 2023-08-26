import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:dash/models/posts.dart';
import 'package:dash/resource/store_image.dart';
import 'package:uuid/uuid.dart';



class FireStoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> uploadPost(String description,Uint8List file,String uid,String username,String profImage) async{
        String res ="Some Error Occured";
        try{
          String photoUrl=await Storage_Methods().upload_image('posts', file, true);
          String postId=const Uuid().v1();
          Post post=Post(
            description: description,
            uid:uid,
            username:username,
            likes:[],
            postId: postId,
            date_pub: DateTime.now(),
            postUrl: photoUrl,
            profImage: profImage,
          );
          _firestore.collection('posts').doc(postId).set(post.toJson());
          res="Success";
        }
        catch(err){
             res=err.toString();
        }
        return res;
  }
}