import 'package:flutter/material.dart';

const Map<String, dynamic> definitions = {
  "history":{
    "type":{
      "withdraw":Colors.black12,
      "income": {
        "color":Colors.green,
        "icon": Icons.check,
      },
      "expense":{
        "color": Colors.red,
        "icon": Icons.error,
      },
    }
  },

  "colors":{
    "default": Colors.black,
    "background":{
      "blue":Colors.blue
    }
  }
};

const String url = 'http://10.0.2.2:8000/api';


