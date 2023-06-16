import 'package:wafi/config/constanst.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Color currentBackground = definitions['colors']?['background']?['app'];


  set backgroundApp(Color color) {
    currentBackground = color;
    notifyListeners();
  }
}
