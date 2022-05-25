import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screen_director/authToInfo.dart';

import '/Screens/welcome.dart';
import '/services/authentication.dart';

import '/widget/wrapper.dart';

import '/Screens/TestScroll.dart';
import './Screens/AboutScreen.dart';

import '/Screens/LoginScreen.dart';
import '/Screens/InformationScreen.dart';
import '/Screens/HomeScreen.dart';

import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getToken().then((token) {
      print("token $token");
    });

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
            value: Authentication().isAuthenticated(), initialData: null)
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Color.fromRGBO(107, 185, 226, 1)),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          AuthToInfo.route: (_) => AuthToInfo(),
          TestScroll.route: (_) => TestScroll(),
          HomeScreen.route: (_) => HomeScreen(),
          LoginScreen.route: (_) => LoginScreen(),
          InformationScreen.route: (_) => InformationScreen(),
          AboutScreen.route: (_) => AboutScreen(),
          Welcome.route: (_) => Welcome(),
        },
      ),
    );
  }
}
