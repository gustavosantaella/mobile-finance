import 'package:flutter/material.dart';

bottomSheetWafi(context, widget) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: false,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (BuildContext context) {
      return widget;
    },
  );
}
