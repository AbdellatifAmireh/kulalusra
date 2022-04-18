import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({Key? key}) : super(key: key);

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  late WebViewController controller;

  var loadingPercentage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () => _goBack(context),
          child: WebView(
            initialUrl: 'https://www.kulalusra.ae',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            onPageStarted: (url) async {
              //controller.loadUrl('https://www.alkhaleej.ae');
              // if the user click in any url inside the app
              setState(() {
                loadingPercentage = 0;
              });
              print('New url clicked $url');
              final currentUrl = await controller.currentUrl();
              print('New url clicked $currentUrl');
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
                print('progress123 $progress');
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('هل تريد الخروج من التطبيق'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('لا'),
                  ),
                  FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('نعم'),
                  ),
                ],
              ));
      return Future.value(true);
    }
  }
}
