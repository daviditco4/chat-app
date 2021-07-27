import 'package:flutter/material.dart';

import 'password_form_field.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final thm = Theme.of(context);
    final textInputErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: thm.errorColor),
    );
    const verticalSpace = SizedBox(height: 12.0);

    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
                errorBorder: textInputErrorBorder,
                filled: true,
                labelText: 'Email',
              ),
            ),
            verticalSpace,
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                icon: const Icon(Icons.person),
                border: const OutlineInputBorder(),
                errorBorder: textInputErrorBorder,
                filled: true,
                labelText: 'Username',
              ),
            ),
            verticalSpace,
            PasswordFormField(),
            const SizedBox(height: 24.0),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Sign Up Instead'),
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(thm.accentColor),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(thm.accentColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
