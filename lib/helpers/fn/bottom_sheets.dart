import 'package:flutter/material.dart';

bottomSheetWafi(context, widget) async {
  return await showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding:EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
        child: widget,
      );
    },
  );
}
