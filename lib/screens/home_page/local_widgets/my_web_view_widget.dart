import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../pull_to_refresh.dart';

class MyWebViewWidget extends StatefulWidget {
  //Passing url in this widget
  final String initialUrl;

  const MyWebViewWidget({
    Key? key,
    // Passing initialUrl to the state class
    required this.initialUrl,
  }) : super(key: key);

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget>
    with WidgetsBindingObserver {
  //late WebViewController _controller;
  //Start loading from Zero
  var loadingPercentage = 0;
  // ---------
  // Define the WebViewController to use it
  // --------
  late WebViewController _controller;

  // Drag to refresh helpers
  final DragGesturePullToRefresh pullToRefresh = DragGesturePullToRefresh();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

// Implemet initState when user open the app
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

// Implemet dispose when user close the app
  @override
  void dispose() {
    // remove listener
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

// When user pull the WebView implement didChangeMetrics
  @override
  void didChangeMetrics() {
    // on portrait / landscape or other change, recalculate height
    pullToRefresh.setRefreshDistance(MediaQuery.of(context).size.height);
  }

  @override
  Widget build(context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        Completer<void> completer = pullToRefresh.refresh();
        _controller.reload();
        return completer.future;
      },
      child: Stack(
        children: [
          WillPopScope(
            onWillPop: () => _goBack(context),
            child: WebView(
              initialUrl: widget.initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
              gestureNavigationEnabled: true,
              onWebViewCreated: (controller) {
                this._controller = controller;
                //controller.loadUrl('https://www.alkhaleej.ae'); // to load new url
                //controller.reload() // to reload the same page
              },
              onPageStarted: (url) async {
                // if the user click in any url inside the app
                setState(() {
                  loadingPercentage = 0;
                });
                final currentUrl = await _controller.currentUrl();
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
                        _controller.getScrollY().then((value) {
                          if (value == 0 &&
                              dragDownDetails.globalPosition.direction < 1) {
                            _controller.reload();
                          }
                        });
                      },
                  ),
                ),
                // open this protocols in default app
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
          /*if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),*/
          if (loadingPercentage < 100 && Platform.isAndroid)
            Center(child: CircularProgressIndicator()),
          if (loadingPercentage < 100 && Platform.isIOS)
            Center(
                child: CupertinoActivityIndicator(animating: true, radius: 15)),
          //Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
      /* child: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: true,
        gestureNavigationEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          pullToRefresh.dragGestureRecognizer(_refreshIndicatorKey),
        },
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          pullToRefresh.setController(_controller);
        },
        onPageStarted: (String url) { pullToRefresh.started(); },
        onPageFinished: (finish) {    pullToRefresh.finished(); },
        onWebResourceError: (error) {
          debugPrint(
              'MyWebViewWidget:onWebResourceError(): ${error.description}');
          pullToRefresh.finished();
        },
      ), */
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    // if user go back check
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      // dialog to confirm closing
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
