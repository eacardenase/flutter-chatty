import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onSwitchScreen,
  });

  final void Function() onSwitchScreen;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    print({_enteredEmail, _enteredPassword});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              label: Text(
                'Email Address',
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return "Please enter a valid email address";
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredEmail = newValue!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text(
                'Password',
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().length < 6) {
                return "Password must be at least 6 characters long";
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredPassword = newValue!;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: const Text(
              "Login",
            ),
          ),
          TextButton(
            onPressed: widget.onSwitchScreen,
            child: const Text(
              'Create an account',
            ),
          )
        ],
      ),
    );
  }
}
