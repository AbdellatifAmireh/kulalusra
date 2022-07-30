import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewStack extends StatefulWidget {
  const WebViewStack({Key? key}) : super(key: key);

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  late WebViewController controller;
  var loadingPercentage = 0;

  Future<void> _refresh() async {
    controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Stack(
        children: [
          WillPopScope(
            onWillPop: () => _goBack(context),
            child: WebView(
              initialUrl: 'https://www.kulalusra.ae',
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (controller) {
                this.controller = controller;
                //controller.loadUrl('https://www.alkhaleej.ae'); // to load new url
                //controller.reload() // to reload the same page
              },
              onPageStarted: (url) async {
                // if the user click in any url inside the app
                setState(() {
                  loadingPercentage = 0;
                });
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
              gestureRecognizers: Set()
                ..add(
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()
                      ..onDown = (DragDownDetails dragDownDetails) {
                        controller.getScrollY().then((value) {
                          if (value == 0 &&
                              dragDownDetails.globalPosition.direction < 1) {
                            controller.reload();
                          }
                        });
                      },
                  ),
                ),
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains("mailto:")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("tel:")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("whatsapp:")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("twitter")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("facebook")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("instagram")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("pressreader")) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
          /* if (loadingPercentage < 100 && Platform.isAndroid)
            Center(child: CircularProgressIndicator()),
          if (loadingPercentage < 100 && Platform.isIOS)
            Center(
                child: CupertinoActivityIndicator(animating: true, radius: 15)),
          //Center(child: CircularProgressIndicator.adaptive()), */
        ],
      ),
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
