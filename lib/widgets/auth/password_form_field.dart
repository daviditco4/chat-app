import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final errClr = Theme.of(context).errorColor;

    return TextFormField(
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {},
      decoration: InputDecoration(
        icon: const Icon(Icons.password),
        border: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errClr)),
        filled: true,
        labelText: 'Password',
        suffixIcon: InkWell(
          onTap: () => setState(() => _obscureText = !_obscureText),
          customBorder: const CircleBorder(),
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
