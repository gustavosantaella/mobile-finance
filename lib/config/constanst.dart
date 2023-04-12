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

const String url = 'http://192.168.109.48:8000/api';

const String prefixKey = 'Wafi';


