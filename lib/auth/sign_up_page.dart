import 'package:flutter/material.dart';

import '../All_Widget/auth_scaffold.dart';
import 'social_auth_row.dart';

class SignUpPage extends StatefulWidget {
  final bool showBack;
  const SignUpPage({super.key, required this.showBack});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: widget.showBack,
      title: 'Sign up',
      child: Column(
        children: [
          const SizedBox(height: 24),
          const AuthField(hint: 'Name'),
          const SizedBox(height: 12),
          const AuthField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          AuthField(
            hint: 'Password',
            obscureText: _hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _hidePassword = !_hidePassword);
              },
              icon: Icon(
                _hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryAuthButton(
            label: 'SIGN UP',
            onPressed: () {},
          ),
          const SizedBox(height: 44),
          const Text(
            'Or sign up with social account',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          const SocialAuthRow(),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
