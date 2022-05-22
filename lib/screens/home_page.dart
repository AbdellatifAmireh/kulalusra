import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kulalusra/screens/my_web_view_widget.dart';
import 'package:kulalusra/test/_OLD_web_view_stack.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
    initPlatformState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("915b88fb-8d9a-4c1c-9614-2432a6193e50");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    /* // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId("915b88fb-8d9a-4c1c-9614-2432a6193e50");
    debugPrint("FFUTURE");
    // iOS-only method to open launch URLs in Safari when set to false
    OneSignal.shared.setLaunchURLsInApp(true); */
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        //body: WebViewStack(),
        body: MyWebViewWidget(initialUrl: 'https://www.kulalusra.ae',),
      ),
    );
  }
}
