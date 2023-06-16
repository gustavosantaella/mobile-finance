import 'dart:convert';

import 'package:wafi/config/constanst.dart';
import 'package:http/http.dart';

Future<List<dynamic>> getCountriesKeys() async {
  try{
    Response response = await  get(Uri.parse("$url/countries"));
    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res['message']);
    }

    return res['data'];
  }catch(e){
    rethrow;
  }
}