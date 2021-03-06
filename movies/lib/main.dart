import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/controller/app_state.dart';
import 'package:movies/pages/login.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<AppState>(AppState());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginPage(),
      // home: const DefaultTabController(
      //   length: 2,
      //   child: Home(),
      // ),
    )
  );
}
