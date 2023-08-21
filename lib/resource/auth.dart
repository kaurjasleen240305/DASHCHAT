import 'package:dash/resource/store_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:typed_data';


class Authentication{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Uint8List? file;
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
       //email and password are stored in the auth and rest info in the firestore database 
         //Add user to our firestore 
         // creates a collection if it does not exists and then adds the user cred with given info in the bracket as a map
         //if user already exists it will replace that and add this users info in place of it
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username':username,
          'uid':cred.user!.uid,
          'email':email,
          'bio':bio,
          'followers':[],
          'following':[],
          'photo_url':photoUrl,
         });
         result='Success';
         //add method to add users without uid if u dont need uid anywhere in the app
       /*  await _firestore.collection('users').add({

        }) */

       }
    }
    catch(e){
        result=e.toString();
    }
    return result;
  }
}