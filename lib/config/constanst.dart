import 'package:flutter/foundation.dart';
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
      "blue":Colors.blue,
      "app": Color.fromARGB(200, 235, 139, 14)
    }
  }
};

const String url = !kReleaseMode ? 'http://10.0.2.2:8000/api' : '';

const String prefixKey = 'Wafi';

const String ok = 'OK';


