import 'package:dash/resource/auth.dart';
import 'package:dash/resource/auth.dart';
import 'package:flutter/material.dart';
import 'package:dash/models/users.dart';


class UserProvider with ChangeNotifier{
  User? _user;
  final _auth=Authentication();
  User get getUser => _user!;
  Future<void> refreshUser() async{
       User user=await _auth.getUserDetails();
       _user=user;
       notifyListeners();
  }
}