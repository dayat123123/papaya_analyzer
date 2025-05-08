import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:papayas_analyzer/app.dart';
import 'package:papayas_analyzer/injector.dart';

final injector = GetIt.I;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await initializeApp();
  await initializeDateFormatting('en', null);
  runApp(const App());
}
