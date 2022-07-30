
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Arabic RTL config START
      // To localize the app in Arabic
      localizationsDelegates: const [
        // localize for iOS
        GlobalCupertinoLocalizations.delegate,
        // localize for Android
        GlobalMaterialLocalizations.delegate,
        // localize for Widgets
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AR"), //  RTL Right-To-Left locales
      ],
      locale: const Locale("ar", "AR"),
      // Arabic RTL config END
      //
      // To remove the Debug Banner
      debugShowCheckedModeBanner: false,
      title: 'كل الأسرة',
      theme: ThemeData(
        // Main color for the App
        primarySwatch: Colors.orange,
      ),
      // Main screen
      home: const HomePage(),
    );
  }
}