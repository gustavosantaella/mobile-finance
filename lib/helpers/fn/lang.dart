import 'dart:ui';

String lang(String key) {
  Map<String, Map<String, String>> languages = {
    "es": {
      "Hey!, I'm sad": "Ey! No me haz usado en 30 minutos.",
      "You have not used me":"Recuerda que gestionar tus finanzas es importante para tu economia",
      "income":"Ingresos",
      'If you want to reset password, you can to insert a new password in  the following input, after that you can login whit your new password.': "Si quieres restablecer tu contraseña, puedes hacer uso del siguiente campo de entrada. Luego podras iniciar sesion con tu nueva contraseña",
      "Restore": "Restablecer",
      "This action is very dangerous because delete your finance history. Then you can register new finances again. \n\n This is very used to restore your history or if you need restore your balance.": "Esta accion es muy riesgosa porque elimina todas tu historial de finanzas. Si buscar restablecer tu historial o tu balance haga uso del siguiente boton.",
      "Anually": "Anualmente",
      "This feature is beign developed": "Esta funcionalidad esta siendo desarrollada",
      "Quarterly": "Trimestralmente",
      "New password": "Nueva contraseña",
      "Daily": "Diariamente",
      "Monthly": "Mensualmente",
      "Logout": "Cerrar sesion",
      "Change subscription":"Cambiar subscripcion",
      "Restore finances": "Restablecer finanzas",
      "Delete account": "Eliminar cuenta",
      "Schedule name": "Nombre de la programacion",
      "Check token": "Verificar codigo",
      "Next date":"Proxima fecha",
      "Cancel": "Cancelar",
      "expense":"Egresos",
      "Movements": "Movimientos",
      "Verification code": "Codigo de verificacion",
      "Get token": "Obtener codigo",
      "Schedules": "Programaciones",
      "Incomes": "Ingresos",
      "Forgot password": "Recuperar contrasena",
      "Expenses": "Egresos",
      "Amount":"Monto",
      "Calendar": "Calendario",
      "Type":"Tipo",
      "Category":"Categoria",
      "Provider":"Proveedor",
      "You can manage your finances with me": 'Empieza a manejar tus finanzas conmigo',
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
