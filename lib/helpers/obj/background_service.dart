import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:logger/logger.dart';
import 'package:wafi/helpers/notifications/main.dart';

Logger logger = Logger();

class LocalBackgroundService {
  static void init() {
    try {
      logger.d('initialize background services');
      FlutterBackgroundService service = FlutterBackgroundService();
      AndroidConfiguration androidConfiguration = AndroidConfiguration(
        onStart: LocalBackgroundService.onStart,
        isForegroundMode: true,
        autoStart: true,
        foregroundServiceNotificationId: 888,
      );

      IosConfiguration iosConfiguration = IosConfiguration();

      service.configure(
          androidConfiguration: androidConfiguration,
          iosConfiguration: iosConfiguration);

      service.startService();

      logger.d("configured");
    } catch (e) {
      logger.e('error', e.toString());
    }
  }

  @pragma("vm:entry-point")
  static void onStart(ServiceInstance service) async {
    try {
      logger.d('initialize onStart method background services');
      DartPluginRegistrant.ensureInitialized();

      service.on('setAsForeground').listen((event) {});

      service.on('setAsBackground').listen((event) {});

      service.on('stopService').listen((event) {
        service.stopSelf();
      });

      backGroundNotifications.forEach((key, value) {
        value();
      });

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
