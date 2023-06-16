import 'package:flutter/material.dart';

bottomSheetWafi(context, widget, { callback }) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: false,
    useSafeArea: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (BuildContext context) {
      return callback;
    },
  );
}
