import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Storage_Methods{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //function to add profile image to firebase or as post using bool option 
  Future<String> upload_image(String childName,Uint8List file,bool isPost) async{
   Reference ref= _storage.ref().child(childName).child(_auth.currentUser!.uid);
   UploadTask upload= ref.putData(file);
   TaskSnapshot snapshot=await  upload;
   String st= await snapshot.ref.getDownloadURL();
   return st;
  }
}