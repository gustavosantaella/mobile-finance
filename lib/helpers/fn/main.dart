import 'dart:math';

import 'package:finance/config/constanst.dart';
import 'package:flutter/material.dart';

String formatBearerToken(String token) {
  return "$prefixKey $token";
}

Color getRandomColor() {
  List<Color> primaries = Colors.primaries;
  Random random = Random();
  return primaries[random.nextInt(primaries.length)];
}

Color colorFromHexString(String color) {
  return Color(int.parse(color.substring(1), radix: 16) + 0xff000000);
}

Map toMap(data) {
  Map map = {};
  data?.forEach((key, value) => map[key] = value);
  return map;
}
