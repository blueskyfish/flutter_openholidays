import 'dart:ffi';

import 'package:calendar_app/calendar.state.dart';
import 'package:calendar_app/holiday.page.dart';
import 'package:calendar_app/start.page.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CalendarState>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Country'),
        actions: [
          IconButton(
              onPressed: () {
                confirmDelete(context).then((bool? value) {
                  if (value != null && value) {
                    state.reset();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => StartPage()),
                      (Route<dynamic> route) => false);
                  }
                });
              },
              icon: const Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: ListView.builder(
          itemCount: state.countries.length,
          itemBuilder: (context, index) {
            final country = state.countries[index];
            return ListTile(
              leading: SizedBox(
                width: 48,
                height: 48,
                child: country.flag,
              ),
              title: Text(country.title),
              tileColor: state.isSelected(country)
                  ? theme.colorScheme.inversePrimary
                  : null,
              onTap: () {
                state.selectCountry(country);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HolidayPage(),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Contiue',
        backgroundColor: state.hasCountrySelect()
            ? theme.colorScheme.inversePrimary
            : theme.disabledColor,
        // ignore: prefer_const_constructors
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          if (state.hasCountrySelect()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HolidayPage(),
              ),
            );
          }
        },
      ),
    );
  }

  
}
