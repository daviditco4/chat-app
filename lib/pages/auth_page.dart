// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthPage extends StatelessWidget {
  Future<void> _authenticate(
    BuildContext context,
    Map<String, String> authData,
    bool signup,
  ) async {
    try {
      final AuthResult result;

      if (signup) {
        result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authData['email'],
          password: authData['password'],
        );

        final userProfileInfo = UserUpdateInfo();
        userProfileInfo.displayName = authData['username'];
        await result.user.updateProfile(userProfileInfo);
      } else {
        result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authData['email'],
          password: authData['password'],
        );
      }
    } on PlatformException catch (e) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final theme = Theme.of(context);

      scaffoldMessenger.removeCurrentSnackBar();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: theme.colorScheme.error,
          content: Text(
            e.message ?? 'An error ocurred, please try again.',
            style: TextStyle(color: theme.colorScheme.onError),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(30.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AuthForm(_authenticate),
          ),
        ),
      ),
    );
  }
}
