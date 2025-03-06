import 'package:evently_c13_online/core/providers/locale_provider.dart';
import 'package:evently_c13_online/core/providers/location_provider.dart';
import 'package:evently_c13_online/core/providers/theme_provider.dart';
import 'package:evently_c13_online/core/theme/app_theme.dart';
import 'package:evently_c13_online/firebase_options.dart';
import 'package:evently_c13_online/ui/add_event/add_event.dart';
import 'package:evently_c13_online/ui/home_screen/home_screen.dart';
import 'package:evently_c13_online/ui/login/login_screen.dart';
import 'package:evently_c13_online/ui/onbording/onboarding_setup_screen.dart';
import 'package:evently_c13_online/ui/signup_screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null ) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}


/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);
  print('------------------------------------------------');


  await requestNotificationPermissions();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
      ),

    ], child: MyApp()),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late ThemeProvider themeProvider;

  late LocaleProvider localeProvider;
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeProvider.locale),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      routes: {
        OnboardingSetupScreen.routeName: (_) => OnboardingSetupScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        SignupScreen.routeName: (_) => SignupScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        AddEvent.routeName: (_) => AddEvent(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
Future<void> requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions for iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ User granted permission for notifications');
  } else if (settings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    print('⚠️ User granted provisional permission');
  } else {
    print('❌ User denied notifications');
  }

  if (defaultTargetPlatform == TargetPlatform.android) {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
}