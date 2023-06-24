import 'package:flutter/material.dart';
import 'package:wafi/config/constanst.dart';

class CardWidget extends StatelessWidget {
  final Column content;
  const CardWidget(this.content, {super.key});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: borderRadiusAll,
          color: Colors.white,
          boxShadow: normalShadow),
      margin: const EdgeInsets.all(5),
      child: content,
    ),
    );
  }
}
