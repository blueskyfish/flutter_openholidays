import 'package:calendar_app/start/start.page.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';

class RestartActionIcon extends StatelessWidget {
  final VoidCallback onRestart;
  final String title;

  const RestartActionIcon({super.key, required this.title, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.restart_alt,
        semanticLabel: title,
      ),
      onPressed: () {
        confirmDelete(context).then((value) {
          if (value != null && !value) {
            return;
          }
          Future.delayed(
            const Duration(milliseconds: 50),
            () => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const StartPage()),
                (Route<dynamic> route) => false,
              ),
            },
          );
        });
      },
    );
  }
}
