import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:calendar_app/common/load-indicator-widget.dart';
import 'package:calendar_app/state/holiday-service.dart';
import 'package:calendar_app/state/holiday-state.dart';
import 'package:calendar_app/start/start.page.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HolidayState>();
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
    );
  }

  Widget _buildBody(
    BuildContext context,
  ) {
    return FutureBuilder(
      future: HolidayService.loadCountryList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildListView(context, snapshot.data!);
        }

        return const LoadIndivator(
          text: 'Load country list ...',
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, IconListItemController controller) {
    return ListView.builder(
      itemCount: controller.length,
      itemBuilder: (context, index) => IconListTile(
        index: index,
        controller: controller,
      ),
    );
  }
}
