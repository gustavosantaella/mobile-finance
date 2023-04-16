import 'dart:math';

import 'package:finance/config/constanst.dart';
import 'package:flutter/material.dart';

String formatBearerToken(String token){

  return "$prefixKey $token";
}

Color getRandomColor() {
  List<Color> primaries = Colors.primaries;
  Random random = Random();
  return primaries[random.nextInt(primaries.length)];
}