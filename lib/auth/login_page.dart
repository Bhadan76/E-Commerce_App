import 'package:flutter/material.dart';

import '../visual_search/visual_search_page.dart';
import '../All_Widget/auth_scaffold.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';
import 'social_auth_row.dart';

class LoginPage extends StatefulWidget {
  final bool showBack;
  const LoginPage({super.key, required this.showBack});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: widget.showBack,
      title: 'Login',
      child: Column(
        children: [
          const SizedBox(height: 24),
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
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordPage(showBack: true),
                  ),
                );
              },
              child: const Text(
                'Forgot your password?',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 10),
          PrimaryAuthButton(
            label: 'LOGIN',
            onPressed: () {},
          ),
          const SizedBox(height: 44),
          const Text(
            'Or login with social account',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          const  SocialAuthRow(),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpPage(showBack: true)),
              );
            },
            child: const Text(
              "Don't have an account? Sign up",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VisualSearchPage()),
              );
            },
            child: const Text(
              "Try Visual Search Flow (Figma Design)",
              style: TextStyle(fontSize: 14, color: Color(0xFFDB3022), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
