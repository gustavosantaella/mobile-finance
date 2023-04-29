import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  dynamic userId;

  get id {
    var a = 2+ 2;

    return a;
  }

  set setUserId(String userId){
    this.userId = userId;
  }
}