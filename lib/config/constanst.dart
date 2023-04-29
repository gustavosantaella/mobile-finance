import 'package:finance/helpers/fn/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

 Map<String, dynamic> definitions = {
  "history": {
    "type": {
      "withdraw": Colors.black12,
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
      "hexadecimal":{
        "blue":"#38b6ff",
        "cobalto":"#004aad"
      },
      "blue": Colors.blue,
      "app": colorFromHexString("#38b6ff"),
    },
      "cobalto":colorFromHexString("#004aad")
  }
};

const String url = !kReleaseMode ? 'https://b1e4-190-79-162-128.ngrok.io/api' : 'https://finance-backend-klzw.onrender.com/api';

// Just if your use ngrok [RECOMENDED]
// const String url = !kReleaseMode
//     ? 'https://ecab-190-79-162-128.ngrok.io/api'
//     : 'https://finance-backend-klzw.onrender.com/api';

const String prefixKey = 'Wafi';

const String appName = 'Wafi';

const String ok = 'OK';

Function GeneralInputStyle =  ( {labelText = '', border }) =>  InputDecoration(
  fillColor: Colors.white,
  filled: true,

  border: border ??
       const OutlineInputBorder(
        
        borderRadius: BorderRadius.all(Radius.circular(20))),
  labelText: labelText,
);


const borderRadiusAll =  BorderRadius.all(Radius.circular(15));

const marginAll =  EdgeInsets.all(20);
