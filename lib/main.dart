import 'package:flutter/material.dart';

import 'pages/auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.purple;
    final defaultTextTheme = Typography.material2018().englishLike;

    return GestureDetector(
      onTap: () {
        final focusScope = FocusScope.of(context);
        if (!focusScope.hasPrimaryFocus) focusScope.unfocus();
      },
      child: MaterialApp(
        title: 'Chat App',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.dark(
            primary: primaryColor,
            secondary: Colors.deepOrange.shade300,
            onPrimary: Colors.white,
          ),
          textTheme: defaultTextTheme.apply(fontFamily: 'Oxygen'),
        ).copyWith(
          primaryColor: primaryColor,
          primaryColorBrightness: Brightness.dark,
          primaryColorLight: const Color(0xFFD05CE3),
          primaryColorDark: const Color(0xFF6A0080),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            filled: true,
            errorMaxLines: 3,
          ),
          fixTextFieldOutlineLabel: true,
        ),
        home: AuthPage(),
      ),
    );
  }
}
