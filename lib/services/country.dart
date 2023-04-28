import 'dart:convert';

import 'package:finance/config/constanst.dart';
import 'package:http/http.dart';

Future<List<dynamic>> getCountriesKeys() async {
  try{
    Response response = await  get(Uri.parse("$url/countries"));
    Map res = jsonDecode(response.body);
    if(res['ok'] != ok){
      throw Exception(res['error']);
    }

    return res['data'];
  }catch(e){
    rethrow;
  }
}