import 'package:wafi/helpers/fn/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// http://10.0.2.2 -> LOCALHOST 
// http://54.221.67.193 -> prod

// http://10.0.2.2 -> LOCALHOST 
// http://54.221.67.193 -> prod

Map<String, dynamic> definitions = {
  "google": {
    "recaptcha":{
      "secret": "6Lf0-aomAAAAAAkkAb6mFaZ1EYSojo4R5lBU2iKp",
      "webKey": "6Lf0-aomAAAAAF3KI-67Q0SdTNkMIKQg2_YfvAF-"
    }
  },
  "notifications":{
    "local":{
      "foregroundServiceNotificationId": 888
    }
  },
  "schedules":{
    "finances": ["Daily", 'Monthly', "Quarterly", "Anually"],
    "subscriptions": [],
  },
  "history": {
    "type": {
      // "withdraw": Colors.black12,
      "income": {
        "color": Colors.green,
        "icon": Icons.check,
      },
      "expense": {
        "color": Colors.red,
        "icon": Icons.error,
      },
    }
  },
  "colors": {
    "default": Colors.black,
    "background": {
      "hexadecimal": {"blue": "#38b6ff", "cobalto": "#004aad"},
      "blue": Colors.blue,
      "app": Colors.white,
    },
    "splash": {
      "main": colorFromHexString("#38b6ff"),
    },
    "blue": colorFromHexString("#38b6ff"),
    "purple": colorFromHexString("#38b6ff"),
    "cobalto": colorFromHexString("#004aad")
  }
};

const String url = !kReleaseMode
    ? 'http://10.0.2.2:9000/api'
    : 'http://54.221.67.193:9000/api';


const String prefixKey = 'Bearer';

const String appName = 'Wafi';

const String ok = 'OK';

Function generalInputStyle =  ( {labelText = '', border }) =>  const InputDecoration(
  fillColor: Colors.white,
  filled: true,);

const borderRadiusAll = BorderRadius.all(Radius.circular(20));

const marginAll = EdgeInsets.all(20);

const normalShadow = <BoxShadow>[
  BoxShadow(
    color: Color.fromRGBO(40, 4, 4, 0.111),
    blurRadius: 10.0,
    spreadRadius: 2.0,
  )
];

