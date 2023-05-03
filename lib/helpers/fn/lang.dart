import 'dart:ui';
import 'package:logger/logger.dart';

String lang(String key, {String defaultTransalation = 'Without transalation'}) {
  Map<String, Map<String, String>> languages = {
    "es": {
      "Reset password": "Restablecer clave",
      "metrics": "metricas",
      "expenses": "egresos",
      "incomes": "ingresos",
      "New movement": "nuevo movimiento",
      "add": 'agregar',
      'Welcome back': "bienvenido de vuelta",
      "hi": 'Hola',
      "Submit": "Enviar",
      "Dayli metric": "Metricas diarias",
      "email": "correo",
      "Profile": "Perfil",
      "Successfully": 'Hecho'
    },
    "en": {
      "Reset password": "Restablecer clave",
      "expenses": "expenses",
      "incomes": "incomes",
      "new movement": "new movement",
      "add": "add"
    },
  };

  // Logger logger = Logger(level: Logger.level);
  if (languages[window.locale.languageCode]?[key] != null) {
    return languages[window.locale.languageCode]?[key] as String;
  } else {
    return key;
  }
}
