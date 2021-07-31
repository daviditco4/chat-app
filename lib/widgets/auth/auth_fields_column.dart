import 'package:flutter/material.dart';

import 'auth_form.dart' show AuthMode;
import 'confirm_password_form_field.dart';
import 'password_form_field.dart';

class AuthFieldsColumn extends StatefulWidget {
  const AuthFieldsColumn({
    required this.authMode,
    required this.onEmailSaved,
    required this.onUsernameSaved,
    required this.onPasswordSaved,
    this.onSubmitted,
  });

  final AuthMode authMode;
  final void Function(String? newValue) onEmailSaved;
  final void Function(String? newValue) onUsernameSaved;
  final void Function(String? newValue) onPasswordSaved;
  final void Function(String value)? onSubmitted;

  @override
  _AuthFieldsColumnState createState() => _AuthFieldsColumnState();
}

class _AuthFieldsColumnState extends State<AuthFieldsColumn> {
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  static final _usernameRegExp = RegExp(
    r"^(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$",
  );

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedChildVisibleOnCondition({
    required bool condition,
    required Widget child,
    SizedBox topVerticalSpace = const SizedBox(),
  }) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.ease,
      alignment: Alignment.bottomCenter,
      crossFadeState:
          condition ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: Container(),
      secondChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [topVerticalSpace, if (condition) child],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context);
    const verticalSpace = SizedBox(height: 18.0);
    final sgninMode = (widget.authMode == AuthMode.signin);

    return Theme(
      data: th.copyWith(
        colorScheme: th.colorScheme.copyWith(primary: th.colorScheme.secondary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value != null && _emailRegExp.hasMatch(value)) return null;
              return 'Enter a valid email address.';
            },
            onSaved: widget.onEmailSaved,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
          ),
          _buildAnimatedChildVisibleOnCondition(
            condition: !sgninMode,
            topVerticalSpace: verticalSpace,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              validator: (val) {
                if (sgninMode) {
                  return null;
                } else if (val == null || val.length < 8 || val.length > 20) {
                  return 'The username must have between 8 and 20 characters '
                      'in total.';
                } else if (!_usernameRegExp.hasMatch(val)) {
                  return 'The username must only contain letters, numbers '
                      'or single dots/underscores in between.';
                }
                return null;
              },
              onSaved: widget.onUsernameSaved,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Username',
              ),
            ),
          ),
          verticalSpace,
          PasswordFormField(
            controller: sgninMode ? null : _passwordController,
            onSubmitted: sgninMode ? widget.onSubmitted : null,
            onSaved: sgninMode ? widget.onPasswordSaved : null,
          ),
          _buildAnimatedChildVisibleOnCondition(
            condition: !sgninMode,
            topVerticalSpace: verticalSpace,
            child: ConfirmPasswordFormField(
              validator: (value) {
                if (sgninMode || value == _passwordController.text) return null;
                return 'Passwords do not match.';
              },
              onFieldSubmitted: widget.onSubmitted,
              onSaved: widget.onPasswordSaved,
            ),
          ),
        ],
      ),
    );
  }
}
