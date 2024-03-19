import 'package:flutter/material.dart';

class LoadIndivator extends StatelessWidget {
  final String text;
  const LoadIndivator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    return Center(
      child: Column(
        children: [
          Text(
            text,
            style: textStyle,
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
