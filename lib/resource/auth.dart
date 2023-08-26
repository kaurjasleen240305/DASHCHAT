import 'package:dash/resource/store_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dash/models/users.dart' as model_user;
import 'dart:typed_data';


class Authentication{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Uint8List? file;

  Future<model_user.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    return model_user.User.fromSnap(snap);
  }
  //sign up user 
  Future<String> sign_up({required String email,required String password,required String username,required String bio,required Uint8List file}) async{
    String result='Some error occured';
    await Firebase.initializeApp;
    try{
       if(email.isNotEmpty|| password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file==null){
         //register user
         UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
         print(cred.user!.uid);
         String photoUrl=await Storage_Methods().upload_image('Profile_pics', file, false);
         model_user.User user=model_user.User(
          username:username,
          uid:cred.user!.uid,
          email:email,
          bio:bio,
          followers:[],
          following:[],
          profile_pic:photoUrl,
         );
       //email and password are stored in the auth and rest info in the firestore database 
         //Add user to our firestore 
         // creates a collection if it does not exists and then adds the user cred with given info in the bracket as a map
         //if user already exists it will replace that and add this users info in place of it
        await _firestore.collection('users').doc(cred.user!.uid).set(
            user.toJson(),
         );
         result='Success';
         //add method to add users without uid if u dont need uid anywhere in the app
       /*  await _firestore.collection('users').add({
        
        }) */
       }
    }
     on FirebaseAuthException catch(err){
           if(err.code=='invalid-email'){
            result='EMAIL IS BADLY FORMATTED';
           }else if (err.code=='weak-password'){
            result='PASSWORD MUST CONTAIN AT LEAST 6 CHARACTERS';
           }
      }
    catch(e){
        result=e.toString();
    }
    return result;
  }

  Future<String> login({required String email,required String password}) async{
    String res="Some error occured";
    try{
          if(email.isNotEmpty && password.isNotEmpty){
            await _auth.signInWithEmailAndPassword(email: email, password: password);
            res="Success";
          }
          else{
            res="Enter all the fields";
          }
    }
    on FirebaseAuthException catch(err){
      if(err.code=='user-not-found'){
        res=err.code;
        return res;
      }
    }
    catch(err){
      return err.toString();
    }
    return res;
  }


}