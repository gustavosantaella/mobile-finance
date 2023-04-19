import 'package:flutter/material.dart';

bottomSheetWafi(context, widget) async {
  await showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (BuildContext context) {
      return widget;
    },
  );
}
