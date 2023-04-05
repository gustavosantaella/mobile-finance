import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:finance/config/constanst.dart';
import 'package:finance/database/main.dart';
import 'package:sqflite/sqflite.dart';

Future<dynamic> login(String email, String password) async {
  try {
    dynamic response = await http.post(Uri.parse("$url/auth/login"),
    headers: {
      "Content-Type":"application/json"
    },
        body: jsonEncode({"email": email, "password": password}));
    response = jsonDecode(response.body);
    if(response['status'] != 200){
      return response['error'];
    }
   DB conn = DB();
   Database db  = await conn.openDB();
  //  db.insert("user", {
  //   "token": 
  //  });
    return null;
  } catch (e) {
    return e.toString();
  }
}
