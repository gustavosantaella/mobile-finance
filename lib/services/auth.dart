import 'dart:convert';

import 'package:finance/helpers/fn/main.dart';
import 'package:http/http.dart' as http;
import 'package:finance/config/constanst.dart';
import 'package:finance/database/main.dart';
import 'package:sqflite/sqflite.dart';

Future<dynamic> login(String email, String password) async {
  try {
    dynamic response = await http.post(Uri.parse("$url/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    response = jsonDecode(response.body);
    if (response['status'] != 200) {
      return response['error'];
    }
    DB conn = DB();
    Database db = await conn.openDB();
    await db.rawInsert("INSERT INTO user (token) VALUES (?)", [
      response['data']
    ]);

    return null;
  } catch (e) {
    return e.toString();
  }
}

Future<String> getuserToken({bool formatted = false}) async {
  try {
    DB conn = DB();
    Database db = await conn.openDB();
    List<Map> u = await db.rawQuery("select * from user");
    if(u.isEmpty){
      throw "You can't do it";
    }
    String token = u[0]['token'];
    if(formatted == true){
      token = formatBearerToken(token);
    }

    return token;
  } catch (e) {
    rethrow;
  }
}
