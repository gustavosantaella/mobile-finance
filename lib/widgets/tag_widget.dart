import 'package:flutter/material.dart';
import 'package:wafi/config/constanst.dart';

class TagColorOptions {
  static const warning = Colors.orange;
  static const error = Colors.red;
  static const success = Colors.green;
  static const info = Colors.grey;
  static const canceled = Colors.purple;
}

class Tag extends StatelessWidget {
  final Color color;
  final String text;
  const Tag(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadiusAll
      ),
      child: Text(text, style: const TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),),
    );
  }
}
