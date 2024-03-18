import 'package:calendar_app/start/start-state.dart';
import 'package:calendar_app/country/country-page.dart';
import 'package:calendar_app/holiday-service.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Start'),
        elevation: 4.0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder(
      future: HolidayService.loadLanguageList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildPage(context, snapshot.data!);
        }
        return const Center(
          child: Column(
            children: [Text('Load language list...'), CircularProgressIndicator()],
          ),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, StartState state) {
    return Column(
      children: [
        const Text('Select the language'),
        Expanded(
          child: ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final theme = Theme.of(context);
              final lang = state.languages[index];
              return ListTile(
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: lang.flag,
                ),
                title: Text(lang.name),
                tileColor: state.isSelected(lang) ? theme.colorScheme.inversePrimary : null,
                onTap: () {
                  state.selectLanguage(lang);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CountryPage(),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
