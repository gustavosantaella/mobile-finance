import 'package:cron/cron.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/norifications.dart';
import 'package:wafi/services/auth.dart';
import 'package:flutter/material.dart';

class CronJob {
  static final Cron _cron = Cron();
  static unUnsedApp(AppLifecycleState state) {
    _cron.schedule(Schedule.parse('30 * * * *'), () async {

      late dynamic logged;

      await getuserToken().then((value) => logged = value);
      if(logged != ''){
        showNotificacion(title: lang("Hey!, I'm sad"), content:lang( "You have not used me"), id: 1);
      }
      
    });
  }
}
