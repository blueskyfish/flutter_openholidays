import 'package:calendar_app/common/backward-icon.dart';
import 'package:calendar_app/common/holiday-list-widgets.dart';
import 'package:calendar_app/common/load-indicator-widget.dart';
import 'package:calendar_app/common/restart-action-icon.dart';
import 'package:calendar_app/start/start.page.dart';
import 'package:calendar_app/state/holiday-service.dart';
import 'package:calendar_app/state/holiday-state.dart';
import 'package:calendar_app/util/confirm.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HolidayPage extends StatelessWidget {
  const HolidayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HolidayState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        leading: BackwardIcon(
          title: 'Open Country',
          onBackward: () {
            state.resetHolidays();
          },
        ),
        title: const Text('Holiday List'),
        actions: [
          RestartActionIcon(
            title: 'Restart',
            onRestart: () {
              state.resetState();
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder(
      future: HolidayService.loadHolidays(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildListView(context, snapshot.data!);
        }

        return const LoadIndivator(
          text: 'Load holiday list ...',
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, HolidayListController controller) {
    return ListView.builder(
      itemCount: controller.length,
      itemBuilder: (context, index) => HolidayListTile(
        index: index,
        controller: controller,
      ),
    );
  }
}
