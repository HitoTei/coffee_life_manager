import 'package:flutter/material.dart';

Future<void> showDeleteDialog(BuildContext context, Function() delete) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: const Text('No'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('Yes'),
          onPressed: () {
            delete();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
