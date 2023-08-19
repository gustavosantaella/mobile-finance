
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wafi/config/constanst.dart';
import 'package:wafi/services/auth.dart';

class CategoryService {
  static const String prefix = "categories";
   static Future<Map> createCategory(String name, String lang) async {
      try{  
        String token = await getuserToken(formatted: true);
        Response response = await post(Uri.parse("$url/$prefix/create"),
        headers:  {
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({ "name": name, "lang": lang})
        );

        Map res = jsonDecode(response.body);
        if(res['ok'] != ok){
          throw Exception(res['message']);
        }
        return {
          "label":res["data"]['name'],
          "id": res["data"]['_id'],
          "lang": res["data"]['lang']
        };
      }catch(e){
        rethrow;
      }
   }
}