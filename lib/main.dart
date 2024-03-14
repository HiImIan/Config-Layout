import 'package:config_layout/home/config_page.dart';
import 'package:config_layout/periods/db/period_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(PeriodModelAdapter());
  await Hive.openBox<PeriodModel>('periods');

  runApp(MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('pt')],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black, primary: Colors.black)),
      home: const ConfigPage()));
}
