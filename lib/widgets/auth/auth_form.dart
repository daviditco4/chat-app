import 'package:flutter/material.dart';

import 'auth_fields_column.dart';

enum AuthMode { signin, signup }

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _userInput = <String, String>{};
  var _authMode = AuthMode.signin;

  void _switchAuthMode() {
    setState(
      () {
        final signinMode = AuthMode.signin;
        _authMode = (_authMode == signinMode) ? AuthMode.signup : signinMode;
      },
    );
  }

  void _submit() {
    final form = _formKey.currentState!;

    if (form.validate()) {
      form.save();

      switch (_authMode) {
        case AuthMode.signin:
          print('Signing in with values: $_userInput');
          break;
        case AuthMode.signup:
          print('Signing up with values: $_userInput');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSigninMode = (_authMode == AuthMode.signin);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AuthFieldsColumn(
              authMode: _authMode,
              onEmailSaved: (newValue) => _userInput['email'] = newValue!,
              onUsernameSaved: (newValue) => _userInput['username'] = newValue!,
              onPasswordSaved: (newValue) => _userInput['password'] = newValue!,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24.0),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Sign ${isSigninMode ? 'Up' : 'In'} Instead'),
                  onPressed: _switchAuthMode,
                ),
                ElevatedButton(
                  child: Text('Sign ${isSigninMode ? 'In' : 'Up'}'),
                  onPressed: _submit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
