import 'package:calendar_app/country.page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Start'),
      ),
      body: const Center(
        child: Text('Start'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Start',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CountryPage(),
            )
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
