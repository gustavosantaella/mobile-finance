import 'dart:async';

import 'package:hive/hive.dart';
import 'package:wafi/helpers/fn/lang.dart';
import 'package:wafi/helpers/fn/norifications.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final backGroundNotifications = {
  "rememberUseApp": () async {
    Timer.periodic(const Duration(minutes: 30), (timer) async {
      final appDocumentDirectory =
          await path_provider.getApplicationDocumentsDirectory();
      bool boxExists =
          await Hive.boxExists('user', path: appDocumentDirectory.path);
      if (boxExists) {
        showNotificacion(
            title: lang('Ey! remeber to register a new finance'),
            content: lang(
                "Register a new financing. If you manage your finances you can detect some flaws"),
            id: 888);
      } else {
        showNotificacion(
            title: lang('Ey! Make login and get started'),
            content: lang(
                "Make login and get started to manager your finances with me"),
            id: 888);
      }

      /// OPTIONAL for use custom notification
      /// the notification id must be equals with AndroidConfiguration when you call configure() method.
      // showNotificacion(title: 'hola', content: "amigo", id: 888);
    });
  },
};
