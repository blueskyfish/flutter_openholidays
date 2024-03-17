import 'package:calendar_app/calendar.state.dart';
import 'package:calendar_app/start.page.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HolidayPage extends StatelessWidget {
  const HolidayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: const Text('Holidays'),
        actions: [
          IconButton(
            onPressed: () {
              confirmDelete(context).then((bool? value) {
                if (value != null && value) {
                  state.reset();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const StartPage()),
                      (Route<dynamic> route) => false);
                }
              });
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              print('Holiday Refresh');
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: const Center(
        child: Text('Holidays'),
      ),
    );
  }
}
