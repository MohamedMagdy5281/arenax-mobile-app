import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/AppLoader/presentation/views/app_loader_view.dart';

Future<void> requestPermissions() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}

Future<void> handlePushNotification(RemoteMessage message) async {
  await Firebase.initializeApp();

  int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: notificationId,
      channelKey: 'athbit',
      title: message.notification?.title,
      body: message.notification?.body,
      icon: 'resource://mipmap/notification_logo',
      hideLargeIconOnExpand: false,
      showWhen: true,
    ),
  );
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    try {
      // if (message.notification == null && message.data.isEmpty) {
      //   return;
      // }

      int notificationId =
          DateTime.now().millisecondsSinceEpoch.remainder(100000);

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'befluent',
          title: message.notification?.title,
          body: message.notification?.body,
          icon: 'resource://mipmap/notification_logo',
          hideLargeIconOnExpand: false,
          showWhen: true,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint("Error in onMessage: $e");
      debugPrint(stackTrace.toString());
    }
  });

  // Handle notification tap when app is in terminated state
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      handleNotificationTap();
    }
  });

  // Handle notification tap when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handleNotificationTap();
  });

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (receivedAction) async {
      handleNotificationTap();
    },
  );
}

void handleNotificationTap() {
  globals.navigatorKey.currentState!.pushNamed(AppLoaderView.id);
}
