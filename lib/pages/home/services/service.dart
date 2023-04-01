import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_choices/search_choices.dart';

const String url = 'http://10.0.2.2:8000/api';

Future<List> getCategoriest() async {
  try {
    var data = await http.get(
      Uri.parse("$url/categories"),
      headers: {"Authorization": "Wafi eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NDI4NTYzOWNiNmY2MWQzMzRmNGU1MGUifQ.IWGhoM4Lby4NnAL7vwnsbZeAkRzdSZz08NIwJ7il8SI"},
    );
    var payload = jsonDecode(data.body);
    if (data.statusCode != 200) {
      throw payload['error'];
    } 

    return payload['data'];
  } catch (e) {
    
    throw e.toString();
  }
}
