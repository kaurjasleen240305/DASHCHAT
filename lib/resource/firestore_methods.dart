import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:dash/models/posts.dart';
import 'package:dash/resource/store_image.dart';
import 'package:uuid/uuid.dart';



class FireStoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String> uploadPost(String description,Uint8List file,String uid,String username) async{
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
          );
          _firestore.collection('posts').doc(postId).set(post.toJson());
          res="Success";
        }
        catch(err){
             res=err.toString();
        }
        return res;
  }


  Future<void> likePost(String postId,String uid,List likes) async{
      try{
          if(likes.contains(uid)){
            await _firestore.collection('posts').doc(postId).update({
                'likes':FieldValue.arrayRemove([uid]),
            });
          }
          else{
             await _firestore.collection('posts').doc(postId).update({
                'likes':FieldValue.arrayUnion([uid]),
            });
          }
      }
      catch(e){
        print(e.toString());
      }
  }

  Future<void> postComment(String postId,String text,String uid,String name) async{
     try{
        if(text.isNotEmpty){
          String commId=const Uuid().v1();
          await _firestore.collection('posts').doc(postId).collection('comments').doc(commId).set({
              'name':name,
              'uid':uid,
              'text':text,
              'commId':commId,
              'date_pub':DateTime.now()
        });
        
        }
        else{
          print('Text is empty');
        }
     }catch(e){
      print(e.toString());
     }
  }

  Future<void> followUser(String uid,String followId) async{
      try{
        DocumentSnapshot snap= await _firestore.collection('users').doc(uid).get();
        List following=(snap.data() as dynamic)['following'];
        if(following.contains(followId)){
          await _firestore.collection('users').doc(followId).update({
             'followers': FieldValue.arrayRemove([uid])
          });
          await _firestore.collection('users').doc(uid).update({
             'following': FieldValue.arrayRemove([followId])
          });
        } 
        else{
          await _firestore.collection('users').doc(followId).update({
             'followers': FieldValue.arrayUnion([uid])
          });
          await _firestore.collection('users').doc(uid).update({
             'following': FieldValue.arrayUnion([followId])
          });
        }
      }catch(e){
        print(e.toString());
      }
  }


  
}