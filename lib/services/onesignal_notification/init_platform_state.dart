import 'package:onesignal_flutter/onesignal_flutter.dart';

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
