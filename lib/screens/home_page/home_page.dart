import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kulalusra/screens/home_page/local_widgets/my_web_view_widget.dart';
import 'package:kulalusra/dummy_codes/_OLD_web_view_stack.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/strings.dart';
import '../../services/onesignal_notification/init_platform_state.dart';

class HomePage extends StatefulWidget {
  // Passing a GlobalKey
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final Completer<WebViewController> _controllerCompleter = Completer<WebViewController>();

  //Implements this code once the app initiated
  @override
  void initState() {
    super.initState();
    initPlatformState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // Scaffold to implement appBar,drawer, bottomNavigationBar, floatingActionButton
      child: Scaffold(
        //body: WebViewStack(),
        body: MyWebViewWidget(
          // webview url
          initialUrl: baseUrl,
        ),
      ),
    );
  }
}
