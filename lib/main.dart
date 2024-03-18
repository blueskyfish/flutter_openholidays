import 'package:calendar_app/holiday-state.dart';
import 'package:calendar_app/start/start.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HolidayState(),
      child: MaterialApp(
        title: 'Open Holidays App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const StartPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
