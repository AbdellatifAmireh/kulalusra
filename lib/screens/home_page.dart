import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kulalusra/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final Completer<WebViewController> _controllerCompleter = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

/*   @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  } */

/*   @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId("f702fd96-675c-481e-ad37-4e9c8d788135");
    debugPrint("FFUTURE");
    // iOS-only method to open launch URLs in Safari when set to false
    OneSignal.shared.setLaunchURLsInApp(true);
  } */

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WebViewStack(),
      ),
    );
  }
}
