import 'dart:ui';

String lang(String key, {String defaultTransalation = 'Without transalation'}) {
  Map<String, Map<String, String>> languages = {
    "es": {
      "Hey!, I'm sad": "Ey! No me haz usado en 30 minutos.",
      "You have not used me":"Recuerda que gestionar tus finanzas es importante para tu economia",
      "income":"Ingresos",
      "Logout": "Cerrar sesion",
      "expense":"Egresos",
      "Movements": "Movimientos",
      "Incomes": "Ingresos",
      "Expenses": "Egresos",
      "Amount":"Monto",
      "Calendar": "Calendario",
      "Type":"Tipo",
      "Category":"Categoria",
      "Provider":"Proveedor",
      "You can to manage your finnaces with me": 'Empieza a manejar tus finanzas conmigo',
      "Register now":"Registrate ahora",
      "Just one step for you to start managing your finance":
          "A un solo paso de poder gestionar tus finanzas",
      "Country": 'Pais',
      "Password": 'Clave',
      "Email": "Correo",
      "Sign In": "Iniciar sesion",
      "Sign Up": "Registrarse",
      "Have an account?": "Tienes una cuenta?",
      "Reset password": "Restablecer clave",
      "metrics": "metricas",
      "expenses": "Egresos",
      "ADD MOVEMENT":"AGREGAR NUEVO MOVIMIENTO",
      "incomes": "Ingresos",
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
      "expenses": "Expenses",
      "incomes": "Incomes",
      "hi": "Hi",
      "new movement": "new movement",
      "add": "add"
    },
  };
  if (languages[window.locale.languageCode]?[key] != null) {
    return languages[window.locale.languageCode]?[key] as String;
  } else {
    return key;
  }
}
