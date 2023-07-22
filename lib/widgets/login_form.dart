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
  @override
  Widget build(BuildContext context) {
    return Form(
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
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text(
                'Password',
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {},
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
