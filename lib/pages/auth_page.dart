import 'package:flutter/material.dart';

import '../widgets/auth/auth_form.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(30.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AuthForm(),
          ),
        ),
      ),
    );
  }
}
