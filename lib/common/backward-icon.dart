import 'package:flutter/material.dart';

class BackwardIcon extends StatelessWidget {
  final VoidCallback onBackward;
  final String title;
  const BackwardIcon({super.key, required this.title, required this.onBackward});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 50), () => onBackward());
      },
      icon: Icon(
        Icons.chevron_left,
        semanticLabel: title,
      ),
      iconSize: 32.0,
    );
  }
}
