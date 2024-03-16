import 'package:flutter/material.dart';

Future<bool?> confirmDelete(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      final removeAction = TextButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text('Remove'),
      );
      final cancelAction = TextButton(
        onPressed: () {
          Navigator.pop(context, false);
        },
        child: const Text('Cancel'),
      );

      return AlertDialog(
        title: const Text('Remove'),
        content:
            const Text('Do you want to remove all selection and start again?'),
        actions: [
          removeAction,
          cancelAction,
        ],
      );
    },
  );
}
