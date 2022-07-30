import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kulalusra/screens/home_page/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'my_app.dart';


void main() {
  // ......
  // Define a style and colors for the app..
  // ......
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      //statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          // This line to show the icons in status bar.
          Brightness.dark, // Dark == white status bar -- for IOS.
    ),
  );
  runApp(const MyApp());
}