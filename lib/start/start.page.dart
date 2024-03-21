
import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:calendar_app/common/load-indicator-widget.dart';
import 'package:calendar_app/state/holiday-service.dart';
import 'package:calendar_app/state/holiday-state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<HolidayState>();
    state.initLocales(context);
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
        return const LoadIndivator(
          text: 'Load language list...',
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, IconListItemController controller) {
    var textStyle = Theme.of(context).textTheme.headlineLarge;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
          child: Text(
            'Select the language',
            style: textStyle,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.length,
            itemBuilder: (context, index) => IconListTile(
              index: index,
              controller: controller,
            ),
          ),
        )
      ],
    );
  }
}
