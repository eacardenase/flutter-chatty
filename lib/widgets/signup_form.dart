import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.onSwitchScreen,
  });

  final void Function() onSwitchScreen;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
              'Sign Up',
            ),
          ),
          TextButton(
            onPressed: widget.onSwitchScreen,
            child: const Text(
              'I already have an account.',
            ),
          )
        ],
      ),
    );
  }
}
