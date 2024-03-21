import 'package:calendar_app/common/backward-icon.dart';
import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:calendar_app/common/load-indicator-widget.dart';
import 'package:calendar_app/common/restart-action-icon.dart';
import 'package:calendar_app/state/holiday-service.dart';
import 'package:calendar_app/state/holiday-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HolidayState>();
    return Scaffold(
      appBar: AppBar(
        leading: BackwardIcon(
          title: 'Open Language',
          onBackward: () {
            state.resetCounties();
          },
        ),
        elevation: 4.0,
        title: const Text('Choose Country'),
        actions: [
          RestartActionIcon(
            title: 'Restart',
            onRestart: () {
              state.resetState();
            },
          ),
          IconButton(
            onPressed: () {
              // state.resetCounties();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
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
