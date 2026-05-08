import 'package:flutter/material.dart';

import '../All_Widget/auth_scaffold.dart';

class ForgotPasswordPage extends StatelessWidget {
  final bool showBack;
  const ForgotPasswordPage({super.key, required this.showBack});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: showBack,
      title: 'Forgot password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Please, enter your email address. You will receive a link to create a new password via email.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const AuthField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          PrimaryAuthButton(
            label: 'SEND',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
