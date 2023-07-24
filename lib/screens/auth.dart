import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:chatty/widgets/login_form.dart';
import 'package:chatty/widgets/signup_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;

  void _switchScreen() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = LoginForm(onSwitchScreen: _switchScreen);

    if (!_isLogin) {
      mainContent = SignUpForm(onSwitchScreen: _switchScreen);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(
                    20,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: mainContent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
