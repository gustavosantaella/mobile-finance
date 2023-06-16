import 'package:flutter/material.dart';

class SnackBarMessage{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   SnackBarMessage(BuildContext context,  dynamic message, {Color color = Colors.red}){
      if( message is String ){
        message = Text(message);
      }
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: message, behavior: SnackBarBehavior.floating, backgroundColor: color)
      );
  } 

 
}