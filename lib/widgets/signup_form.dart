import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chatty/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

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
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';
  var _isLoading = false;
  File? _selectedImage;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || _selectedImage == null) {
      // show error message

      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() => _isLoading = true);

      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');

      await storageRef.putFile(_selectedImage!);

      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'userName': _enteredUsername,
        'email': _enteredEmail,
        'imageUrl': imageUrl
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // Handle error...
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Authentication falied.',
          ),
        ),
      );

      setState(() => _isLoading = false);
    }
  }

  void _onPickImage(File image) {
    _selectedImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserImagePicker(onPickImage: _onPickImage),
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
                return 'Please enter a valid email address';
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredEmail = newValue!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            enableSuggestions: false,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 4) {
                return "Please enter at least 4 characters";
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredUsername = newValue!;
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
                return 'Password must be at least 6 characters long';
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
          if (_isLoading) const CircularProgressIndicator(),
          if (!_isLoading)
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text(
                'Sign Up',
              ),
            ),
          if (!_isLoading)
            TextButton(
              onPressed: widget.onSwitchScreen,
              child: const Text(
                'I already have an account',
              ),
            )
        ],
      ),
    );
  }
}
