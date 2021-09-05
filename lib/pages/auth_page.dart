import 'dart:io' show File;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path show extension;

import '../helpers/snack_bars.dart';
import '../widgets/auth/auth_form.dart' show AuthForm;

class AuthPage extends StatelessWidget {
  Future<bool> _authenticate({
    required BuildContext context,
    File? userImage,
    required Map<String, String> authData,
    bool signup = false,
  }) async {
    try {
      if (signup) {
        userImage!;

        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authData['email']!,
          password: authData['password']!,
        );
        final user = res.user!;

        final imageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(user.uid + path.extension(userImage.path));
        await imageRef.putFile(userImage);
        final imageURL = await imageRef.getDownloadURL();

        await user.updateDisplayName(authData['username']!);
        await user.updatePhotoURL(imageURL);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authData['email']!,
          password: authData['password']!,
        );
      }
      return true;
    } on FirebaseException catch (e) {
      SnackBars.showError(context: context, message: e.message);
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
