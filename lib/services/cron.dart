import 'package:cron/cron.dart';
import 'package:finance/services/auth.dart';

class CronJob {
  static final Cron _cron = Cron();
  static unUnsedApp() {
    _cron.schedule(Schedule.parse('* * * * *'), () async {
      late dynamic logged;

      await getuserToken().then((value) => logged = value);
      if(logged){
        print(23);
      }
      
    });
  }
}
