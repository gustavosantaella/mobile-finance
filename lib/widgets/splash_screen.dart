import 'package:wafi/config/constanst.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        color: definitions['colors']['splash']['main'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Text('WAFI', style: TextStyle(
              fontWeight:FontWeight.bold,
              fontSize: 50,
              letterSpacing: 10,
              shadows: normalShadow
            ),),
          ),
           Directionality(
            textDirection: TextDirection.ltr,
            child: Text(lang("You can manage your finances with me"), 
            textAlign: TextAlign.center,
            style:const  TextStyle(
              fontWeight:FontWeight.w300,
              fontSize: 15,
              letterSpacing: 10,
              shadows: normalShadow
            ),),
          ),
          const SizedBox(height: 40,),
          Image.asset('assets/app_icon.png', width: 150, height: 150,)
        ],
      ),
      )
    );
  }
}
