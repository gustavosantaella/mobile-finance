import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  dynamic userId;

  set setUserId(String userId){
    this.userId = userId;
  }
}