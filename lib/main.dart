import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './pages/main_page.dart';
import './pages/splash_page.dart';

void main() {
  runApp(SplashPage(
    key: UniqueKey(),
    onInitializationComplete: () {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flickd",
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => MainPage(),
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
