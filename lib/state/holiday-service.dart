import 'dart:convert';

import 'package:calendar_app/api/core.api.dart';
import 'package:calendar_app/api/country.api.dart';
import 'package:calendar_app/api/holiday.api.dart';
import 'package:calendar_app/api/language.api.dart';
import 'package:calendar_app/common/holiday-list-widgets.dart';
import 'package:calendar_app/common/icon-list-widgets.dart';
import 'package:calendar_app/country/country-page.dart';
import 'package:calendar_app/holiday/holiday-page.dart';
import 'package:calendar_app/state/holiday-state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HolidayService {
  static const Map<String, String> headers = {'accept': 'application.json'};

  static Future<IconListItemController> loadLanguageList(BuildContext context) async {
    final state = Provider.of<HolidayState>(context, listen: false);
    if (state.isLanguageMapEmpty) {
      state.startBackend();
      print('backend: load language list');
      var url = Uri.parse('${state.baseUrl}/Languages?languageIsoCode=${state.languageCode}');
      var response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        throw Exception('Failed to load language list (status=${response.statusCode})');
      }
      var data = json.decode(response.body);
      var languages = fromArray(data, (row) => Language.fromJson(row));

      state.updateLanguages(languages);
    }

    return IconListItemController(state.languages, state.languageCode, (IconListItem language) {
      state.selectLanguage(language.code);
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CountryPage(),
          ),
        );
      });
    });
  }

  static Future<IconListItemController> loadCountryList(BuildContext context) async {
    final state = Provider.of<HolidayState>(context, listen: false);
    if (state.isCountryListEmpty) {
      state.startBackend();
      print('backend: Load country list');
      var url = Uri.parse('${state.baseUrl}/Countries?languageIsoCode=$state.language');
      var response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        throw Exception('Failed to load country list (status=${response.statusCode})');
      }
      var data = json.decode(response.body);
      var countries = fromArray(data, (row) => Country.fromJson(row));

      state.updateCountries(countries);
    }
    return IconListItemController(
      state.countries,
      state.countryCode,
      (country) {
        state.selectCountry(country);

        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HolidayPage(),
            ),
          );
        });
      },
    );
  }

  static Future<HolidayListController> loadHolidays(BuildContext context) async {
    final state = context.watch<HolidayState>();
    if (state.isHolidayListEmpty) {
      state.startBackend();
      final formatter = DateFormat('yyyy-MM-dd');
      var currentYear = DateTime.now().year;
      var startDate = formatter.format(DateTime(currentYear, 1, 1));
      var endDate = formatter.format(DateTime(currentYear, 12, 31));

      var url = Uri.parse(
          '${state.baseUrl}/PublicHolidays?countryIsoCode=${state.countryCode.toUpperCase()}&languageIsoCode=${state.languageCode.toUpperCase()}&validFrom=$startDate&validTo=$endDate');
      var response = await http.get(url, headers: headers);
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load holidays from "${state.countryCode}/${state.languageCode}" from $startDate to $endDate');
      }

      var data = json.decode(response.body);
      var holidays = fromArray(data, (row) => Holiday.fromJson(row));

      state.updateHolidays(holidays);
    }

    return HolidayListController(
      state.holidays,
      state.holidayId,
      (HolidayListItem item) {
        state.selectHoliday(item);
        /*
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const HolidayDetailPage(),
            ),
          );
        });
        */
      },
    );
  }
}
