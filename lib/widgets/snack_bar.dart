import 'package:flutter/material.dart';

class SnackBarMessage{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   SnackBarMessage(BuildContext context, Color color, Widget widget){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: widget, behavior: SnackBarBehavior.floating, backgroundColor: color)
      );
  } 

 
}