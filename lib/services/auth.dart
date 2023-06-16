import 'dart:convert';

import 'package:wafi/helpers/fn/main.dart';
import 'package:wafi/pages/home/widgets/add_movment.dart';
import 'package:wafi/providers/user_provider.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:wafi/config/constanst.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

Future<dynamic> login(String email, String password,
    {required UserProvider userProvider}) async {
  try {
    dynamic response = await http.post(Uri.parse("$url/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    response = jsonDecode(response.body);
    logger.d(response);
    if (response['status'] != 200) {
      return response['message'];
    }
    Box userCollection = await Hive.openBox('user');

    if (userCollection.isEmpty) {
      userCollection.put('token', response['data']['token']);
    }
    userProvider.setUserId = response['data']['userId'];
    return null;
  } catch (e) {
    return e.toString();
  }
}

Future<void> registerUser(payload) async {
  try {
    String jsonencode = jsonEncode(payload);

    http.Response response = await http.post(Uri.parse('$url/auth/register'),
        body: jsonencode, headers: {"Content-Type": "application/json"});
    Map res = jsonDecode(response.body);
    if (res['ok'] != ok) {
      throw Exception(res['message'] ?? 'An error ocurred');
    }

    if (res['data'] != true) {
      throw Exception('Different than true');
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> logout({bool formatted = false}) async {
  try {
    http.Response response = await http.post(Uri.parse('$url/auth/logout'),
        headers: {"Authorization": await getuserToken(formatted: true)});
    // Box userCollection = await Hive.openBox('user');
    // Box historyCollection = await Hive.openBox('history');
    List<Future> futures =
        [ Hive.deleteFromDisk()].toList();

    await Future.wait(futures);
    logger.i('Logout');
  } catch (e) {
    rethrow;
  }
}

Future<String> getuserToken({bool formatted = false}) async {
  try {
    Box userCollection = await Hive.openBox('user');
    String token = '';
    if (userCollection.isNotEmpty) {
      token = userCollection.get('token').toString();
    } else {
      throw "You can't do it";
    }
    if (formatted == true) {
      token = formatBearerToken(token);
    }
    return token;
  } catch (e) {
    print("error to get token");
    rethrow;
  }
}


Future<dynamic> getToken(String email) async {
  try{
    http.Response response = await http.post(Uri.parse("$url/auth/forgot-password"), body: {
      "email": email
    });
    Map res = jsonDecode(response.body);

    if(res['ok'] != ok){
      throw  Exception(res['message']);
    }

  }catch(e){
    return e.toString();
  }
}


Future<dynamic> forgotPasswordValidateCode(String code) async {
  try{
 http.Response response = await http.post(Uri.parse("$url/auth/validate-code"), body: {
      "code": code
    });
    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res["message"]);
    }
    return  res["data"];
  }catch(e){
    rethrow;
  }
}

Future<dynamic> forgotPasswordChange(String password, String email) async {
  try{
 http.Response response = await http.post(Uri.parse("$url/auth/forgot-password-change"), body: {
      "email": email,
      "password": password
    });
    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res["message"]);
    }
    return  res["data"];
  }catch(e){
    rethrow;
  }
}