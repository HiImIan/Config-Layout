import 'package:tarefa_periodo/home/config_page.dart';
import 'package:tarefa_periodo/periods/db/period_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  // inicialização do banco interno Hive antes da aplicação iniciar.
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(PeriodModelAdapter());
  await Hive.openBox<PeriodModel>('periods');

  runApp(MaterialApp(
      //definindo o padrão do idioma como pt br para os widgets
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR')
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black, primary: Colors.black)),
      home: const ConfigPage()));
}
