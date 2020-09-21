import 'package:flutter/material.dart';

Future<bool> showDeleteDialog(BuildContext context, String message) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    child: AlertDialog(
      content: Text(message),
      actions: [
        FlatButton(
          child: Text("No"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FlatButton(
          child: Text("Yes"),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}
