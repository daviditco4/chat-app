import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'pages/auth_page.dart';
import 'pages/chat_page.dart' show ChatPage;
import 'pages/splash_page.dart';

const CHAT_TOPIC = 'public';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.purple;
    final secondaryColor = Colors.deepOrange.shade300;
    final defaultTextTheme = Typography.material2018().englishLike;

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) {
        return GestureDetector(
          onTap: () {
            final focusScope = FocusScope.of(ctx);
            if (!focusScope.hasPrimaryFocus) focusScope.unfocus();
          },
          child: MaterialApp(
            title: 'Chat App',
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.from(
              colorScheme: ColorScheme.dark(
                primary: primaryColor,
                secondary: secondaryColor,
                onPrimary: Colors.white,
              ),
              textTheme: defaultTextTheme.apply(fontFamily: 'Oxygen'),
            ).copyWith(
              primaryColor: primaryColor,
              primaryColorBrightness: Brightness.dark,
              primaryColorLight: const Color(0xFFD05CE3),
              primaryColorDark: const Color(0xFF6A0080),
              applyElevationOverlayColor: true,
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                filled: true,
                errorMaxLines: 3,
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: secondaryColor,
                selectionHandleColor: secondaryColor,
              ),
              fixTextFieldOutlineLabel: true,
            ),
            home: snapshot.connectionState != ConnectionState.done
                ? SplashPage()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (_, snap) {
                      final fcm = FirebaseMessaging.instance;

                      if (snap.connectionState == ConnectionState.waiting) {
                        fcm.requestPermission();
                        return SplashPage();
                      } else if (!snap.hasData) {
                        fcm.unsubscribeFromTopic(CHAT_TOPIC);
                        return AuthPage();
                      }
                      fcm.subscribeToTopic(CHAT_TOPIC);
                      return ChatPage();
                    },
                  ),
          ),
        );
      },
    );
  }
}
