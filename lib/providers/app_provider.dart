import 'package:wafi/config/constanst.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Color currentBackground = definitions['colors']?['background']?['app'];
  Map route = {
    "currentIndex": 0,
  };

  set backgroundApp(Color color) {
    currentBackground = color;
    notifyListeners();
  }

  set setCurrenIndexRoute(int index){
      route['currentIndex'] = index;
      notifyListeners();
  }

  get currentIndexRoute {
    return route['currentIndex'];
  }
}
