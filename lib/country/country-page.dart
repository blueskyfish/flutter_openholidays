
import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/request-countries.dart';
import 'package:calendar_app/country/country-state.dart';
import 'package:calendar_app/holiday-service.dart';
import 'package:calendar_app/holiday-state.dart';
import 'package:calendar_app/holiday-page.dart';
import 'package:calendar_app/start/start.page.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HolidayState>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: const Text('Choose Country'),
        actions: [
          IconButton(
              onPressed: () {
                confirmDelete(context).then((bool? value) {
                  if (value != null && value) {
                    state.reset();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const StartPage()), (Route<dynamic> route) => false);
                  }
                });
              },
              icon: const Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Contiue',
        backgroundColor: state.hasCountrySelect() ? theme.colorScheme.inversePrimary : theme.disabledColor,
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

  Widget _buildBody(BuildContext context,) {
    return FutureBuilder(
      future: HolidayService.loadCountryList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildListView(context, snapshot.data!);
        }

        return const Center(
          child: Column(
            children: [
              Text('Load country list...'),
              CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, CountryState state) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (context, index) {
        final country = state.countries[index];
        return ListTile(
          leading: SizedBox(
            width: 48,
            height: 48,
            child: country.flag,
          ),
          title: Text(country.name),
          tileColor: state.isCountrySelected(country) ? theme.colorScheme.inversePrimary : null,
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
      },
    );
  }
}