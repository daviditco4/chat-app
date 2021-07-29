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
    const verticalSpace = SizedBox(height: 12.0);

    return Form(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: thm.copyWith(
                colorScheme: thm.colorScheme.copyWith(primary: thm.accentColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      labelText: 'Email',
                    ),
                  ),
                  verticalSpace,
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                  ),
                  verticalSpace,
                  PasswordFormField(),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Sign Up Instead'),
                  onPressed: () {},
                ),
                ElevatedButton(child: const Text('Sign In'), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
